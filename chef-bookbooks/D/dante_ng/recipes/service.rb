#
# Cookbook Name:: dante_ng
# Recipe:: service
#
# Copyright 2018, Alexander Merkulov
#

service "#{node['dante_ng']['service']}.service" do
  supports status: true, restart: true, stop: true, start: true
  action :nothing
  ignore_failure true
end

template "/etc/systemd/system/#{node['dante_ng']['service']}.service" do
  source "sockd.service.erb"
  owner 'root'
  group 'root'
  mode 0o0755
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
  notifies :enable, "service[#{node['dante_ng']['service']}.service]", :immediately
  notifies :restart, "service[#{node['dante_ng']['service']}.service]", :delayed
end

execute 'systemctl daemon-reload' do
  action :nothing
end
