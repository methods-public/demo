include_recipe 'runit::default'

# download and install
ark 'dkron' do
  url node['dkron']['download_url']
  checksum node['dkron']['checksum']
  version node['dkron']['version']
  prefix_root node['dkron']['install_path']
  home_dir "#{node['dkron']['install_path']}/current"
  action :install
end

# create the config json
template "#{node['dkron']['install_path']}/current/config/dkron.json" do
  source 'config.json.erb'
  mode '0664'
  variables config: node['dkron']['config']
  notifies :restart, 'runit_service[dkron]'
end

# create a service thru runit
runit_service 'dkron' do
  options(
    home: "#{node['dkron']['install_path']}/current"
  )
  action :enable
end
