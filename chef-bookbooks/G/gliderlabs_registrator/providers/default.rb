#
# Cookbook Name:: gliderlabs_registrator
# Provider:: default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#
use_inline_resources

action :create do
  template '/lib/systemd/system/registrator.service' do
    source 'registrator.service.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      config: new_resource
    )
    cookbook 'gliderlabs_registrator'
    notifies :run, 'execute[systemctl daemon-reload]', :immediately
    action :create
  end

  service 'registrator' do
    supports restart: true, status: true
    action :enable
  end

  # Create config directory
  directory new_resource.conf_dir do
    owner 'root'
    mode '0755'
    action :create
  end

  execute 'systemctl daemon-reload' do
    command '/bin/systemctl daemon-reload'
    action :nothing
  end

  template "#{new_resource.bin_path}/#{new_resource.start_registrator_bin}" do
    cookbook 'gliderlabs_registrator'
    source 'start_registrator.sh.erb'
    mode '755'
    owner 'root'
    group 'root'
    variables config: new_resource
  end

  template "#{new_resource.conf_dir}/registrator.conf" do
    cookbook 'gliderlabs_registrator'
    source 'registrator.conf.erb'
    mode '644'
    owner 'root'
    group 'root'
    notifies :restart, 'service[registrator]'
    variables config: new_resource
  end
end
