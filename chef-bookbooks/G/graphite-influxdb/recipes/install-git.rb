include_recipe 'python'
include_recipe 'git'

directory node['graphite_influxdb']['git']['clone_directory'] do
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

git node['graphite_influxdb']['git']['clone_directory'] do
    repository node['graphite_influxdb']['git']['install_repo']
    revision node['graphite_influxdb']['git']['install_hash']
    action :sync
end

python_pip node['graphite_influxdb']['git']['clone_directory'] do
    action :install
end

