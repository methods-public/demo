#
# Cookbook Name:: vulcand
# Recipe:: default
#
# Copyright 2016, Petr Belyaev <upcfrost@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

case node['vulcand']['install_method']
when 'docker'
  # Pull the vulcand image from Docker Hub
  docker_image node['vulcand']['vulcand_docker_repo'] do
    repo node['vulcand']['vulcand_docker_repo']
    tag node['vulcand']['vulcand_docker_tag']
    action :pull
  end
when 'source_docker'
  # Pull the golang image from Docker Hub
  # Useful for LTS distros with very old golang package
  docker_image node['vulcand']['golang_docker_repo'] do
    repo node['vulcand']['golang_docker_repo']
    tag node['vulcand']['golang_docker_tag']
    action :pull
  end
  docker_container 'vulcand_compile' do
    repo node['vulcand']['golang_docker_repo']
    tag node['vulcand']['golang_docker_tag']
    volumes node['vulcand']['bin_path']
    working_dir node['vulcand']['bin_path']
    env ["GOBIN=#{node['vulcand']['bin_path']}"]
    command node['vulcand']['src_command']
    autoremove true
  end
when 'source'
  # Install golang and build from source
  include_recipe 'golang::default'
  execute 'Compile vulcand' do
    environment 'GOPATH' => '$GOPATH:/tmp', 'GOBIN' => node['vulcand']['bin_path']
    command node['vulcand']['src_command']
  end
end
