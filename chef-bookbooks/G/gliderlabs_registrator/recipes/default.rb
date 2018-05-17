#
# Cookbook Name:: gliderlabs_registrator
# Recipe:: default
#
# Copyright (C) 2016 Petr Belyaev <upcfrost@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

# Pull the docker image from Docker Hub
case node['gliderlabs_registrator']['install_method']
when 'package'
  package 'registrator'
when 'docker'
  docker_service 'default' do
    action [:create, :start]
  end
  docker_image 'gliderlabs/registrator' do
    repo node['gliderlabs_registrator']['registrator_repo']
    tag node['gliderlabs_registrator']['registrator_tag']
    action :pull
  end
when 'source_docker'
  docker_service 'default' do
    action [:create, :start]
  end
  docker_image 'golang' do
    repo node['gliderlabs_registrator']['golang_docker_repo']
    tag node['gliderlabs_registrator']['golang_docker_tag']
    action :pull
  end
  docker_container 'registrator_compile' do
    repo node['gliderlabs_registrator']['golang_docker_repo']
    tag node['gliderlabs_registrator']['golang_docker_tag']
    volumes [format('%s:%s',\
      node['gliderlabs_registrator']['bin_path'],\
      node['gliderlabs_registrator']['bin_path'])]
    working_dir node['gliderlabs_registrator']['bin_path']
    env ["GOBIN=#{node['gliderlabs_registrator']['bin_path']}"]
    command node['gliderlabs_registrator']['src_command']
    detach false
    attach_stdout true
    attach_stderr true
    autoremove true
    timeout 3600
  end
when 'source'
  include_recipe 'golang::default'
  execute 'Compile registrator' do
    environment 'GOPATH' => '$GOPATH:/tmp', 'GOBIN' => node['gliderlabs_registrator']['bin_path']
    command node['gliderlabs_registrator']['src_command']
  end
end
