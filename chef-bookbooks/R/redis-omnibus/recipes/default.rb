include_recipe 'ulimit::default'

# Save once every 15mins
node.default['redis-omnibus']['default_settings']['save'] = ['900 1']
node.default['redis-omnibus']['default_settings']['maxmemory'] = nil

package node['redis-omnibus']['package']

# it seems CentOS default installs creates the user with a shell
# that isnt friendly with here
user 'redis' do
  shell '/bin/sh'
  action :modify
end

include_recipe 'redis-omnibus::remove_package_installer_files'

servers = {}

# Apply the defaults
node['redis-omnibus']['servers'].each do |name, server_options|
  servers[name] = Chef::Mixin::DeepMerge.hash_only_merge(server_options, node['redis-omnibus']['default_settings'])
end

directory '/etc/redis' do
    action :create
end

servers.each do |name, server_options|
  user_ulimit server_options['user'] do
    filehandle_limit server_options['maxclients'] + 32
  end

  # Create the Pid folder (if required)
  directory server_options['piddir'] do
    owner server_options['user']
    group server_options['group']
    mode '0755'
    recursive true
    action :create
  end

  # Write systemd file (if required)
  template "/usr/lib/systemd/system/#{name}-server.service" do
    source 'redis.service.erb'
    variables(
      name: name,
      bin_path: '/usr/bin',
      limit_nofile: server_options['maxclients'],
      user: server_options['user'],
      group: server_options['group']
    )
    only_if { node['init_package'] == 'systemd' }
  end

  # Write init.d file (if required)
  template "/etc/init.d/#{name}-server" do
    source 'redis.init.erb'
    mode 755
    variables Chef::Mixin::DeepMerge.hash_only_merge({ "name" => name, "bin_path" => '/usr/bin' }, server_options)
    only_if { node['init_package'] != 'systemd' }
  end

  # Write redis conf
  template "/etc/redis/#{name}.conf" do
    source 'redis.conf.erb'
    user server_options['user']
    group server_options['group']
    variables Chef::Mixin::DeepMerge.hash_only_merge({ "name" => name, "version" => node['redis-omnibus']['version'] }, server_options)
  end

  service "#{name}-server" do
    service_name "#{name}-server"
    supports enable: true, start: true, restart: true
    action [:enable, :start]
  end
end
