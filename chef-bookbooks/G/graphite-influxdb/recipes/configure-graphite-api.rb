template '/etc/graphite-api.yaml' do
  source 'graphite-api.yaml.erb'
  mode 0644
  owner 'root'
  group 'root'
  notifies :restart, 'service[graphite-api]', :delayed
end
