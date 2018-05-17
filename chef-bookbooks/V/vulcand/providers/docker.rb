#
# Cookbook Name:: vulcand
# Resource:: vulcand_docker
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#
use_inline_resources

action :start do
  docker_container new_resource.container_name do
    repo new_resource.vulcand_docker_repo
    tag new_resource.vulcand_docker_tag
    command [
      new_resource.vulcand_docker_bin, \
      node['vulcand']['run_opts'].map { |k, v| '--' + k.to_s + '=' + v.to_s }.join(' ') \
    ].join(' ')
    port new_resource.container_port
    network_mode new_resource.network_mode
    action :run_if_missing
  end
end

action :stop do
  docker_container new_resource.container_name do
    action [:stop, :delete]
  end
end

action :restart do
  action_stop
  action_start
end
