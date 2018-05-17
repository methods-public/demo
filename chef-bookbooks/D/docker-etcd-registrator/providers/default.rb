#
# Cookbook Name:: docker-etcd-registrator
# Provider:: default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#
use_inline_resources

action :create do
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

  template "#{new_resource.conf_dir}/docker-etcd-registrator.conf" do
    cookbook 'docker-etcd-registrator'
    source 'docker-etcd-registrator.conf.erb'
    mode '644'
    owner 'root'
    group 'root'
    variables config: new_resource
  end

  poise_service_user new_resource.run_user

  poise_service 'docker-etcd-registrator' do
    user new_resource.run_user
    command "/bin/bash -c 'GOMAXPROCS=$(nproc) #{new_resource.docker_etcd_registrator_bin}'"
    options :systemd, after_target: 'docker'
  end
end
