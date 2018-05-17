require 'shellwords'
include_recipe 'chef-vault'

vault_access = true
begin
  vault = chef_vault_item(:credentials, 'noip')
  node.set['noip']['password'] = vault['password']
rescue
  vault_access = false
end

if vault_access
  remote_file File.join(Chef::Config[:file_cache_path],
                        'noip-duc-linux.tar.gz') do
    source 'http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz'
  end

  tarball_x File.join(Chef::Config[:file_cache_path],
                      'noip-duc-linux.tar.gz') do
    destination '/usr/local/src/noip'
  end

  package 'expect'
  package 'gcc'
  package 'make'

  bash 'install agent' do
    user 'root'
    cwd '/usr/local/src/noip'
    code <<-EOF
    cd */
    /usr/bin/expect -c 'spawn make install
    expect "Please enter the login/email string for no-ip.com "
    send "#{node['noip']['username']}\r"
    expect "Please enter the password for user '#{node['noip']['username']}' "
    send "#{node['noip']['password'].shellescape}\r"
    expect "Please enter an update interval:\\[30\\] "
    send "#{node['noip']['interval']}\r"
    expect "Do you wish to run something at successful update?\\[N\\] (y/N) "
    send "n"
    expect eof' &> /tmp/output.txt
    EOF
  end

  template '/etc/init.d/noip2' do
    mode '755'
  end

  if node['platform_family'] == 'rhel'
    template '/etc/systemd/system/noip2.service' do
      mode '644'
      notifies :run, 'execute[reload-systemd]', :immediately
    end
    execute 'reload-systemd' do
      command 'systemctl daemon-reload'
      action :nothing
    end
  end

  service 'noip2' do
    action [:start, :enable]
  end

else
  log 'No access to vault, skipping this run...'
end
