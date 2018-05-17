# recipes/default.rb

# Installs InfluxDB

chef_gem 'toml' do
  compile_time false if respond_to?(:compile_time)
end

chef_gem 'influxdb' do
  compile_time false if respond_to?(:compile_time)
end

influxdb_install 'influxdb' do
  include_repository node['influxdb']['include_repository']
  install_version node['influxdb']['version']
  install_type node['influxdb']['install_type']
  action [:install]
end

influxdb_config node['influxdb']['config_file_path'] do
  config node['influxdb']['config']
  notifies :restart, 'service[influxdb]', :delayed
end

service 'influxdb' do
  supports(restart: true)
  action [:enable, :start]
end
