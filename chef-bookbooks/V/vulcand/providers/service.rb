use_inline_resources
#
# Cookbook Name:: vulcand
# Resource:: vulcand_service
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#

action :create do
  # Create service file
  template '/lib/systemd/system/vulcand.service' do
    source 'vulcand.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables config: new_resource
    cookbook 'vulcand'
    notifies :run, 'execute[systemctl daemon-reload]', :immediately
    action :create
  end

  # Register new service in Chef
  service 'vulcand' do
    supports restart: true, status: true
    action :enable
  end

  # Daemon reload helper
  execute 'systemctl daemon-reload' do
    command '/bin/systemctl daemon-reload'
    action :nothing
  end

  # Create config directory
  directory new_resource.conf_dir do
    owner 'root'
    mode '0755'
    action :create
  end

  # Write the config file into the directory
  template "#{new_resource.conf_dir}/vulcand.conf" do
    cookbook 'docker-etcd-registrator'
    source 'vulcand.conf.erb'
    mode '644'
    owner 'root'
    group 'root'
    notifies :restart, 'service[vulcand]'
    variables config: new_resource
  end
end
