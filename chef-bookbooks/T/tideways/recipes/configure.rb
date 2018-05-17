template "#{node['php']['ext_conf_dir']}/#{node['tideways']['ini_file']}" do
  source 'tideways.ini.erb'
  mode 00644
  owner 'root'
  group 'root'
  notifies :reload, "service[#{node['tideways']['php_service_name']}]"
  variables(
    tideways: node['tideways']
  )
end
