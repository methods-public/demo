#
# Cookbook Name:: elastic_beats_repo
# Recipe:: apt
#
# Copyright 2017, Virender Khatri
#

# filebeat repository attributes
if node['elastic_beats_repo']['version'] < '5.0'
  apt_uri = 'https://packages.elastic.co/beats/apt'
  apt_key = 'https://packages.elastic.co/GPG-KEY-elasticsearch'
else
  major_version = node['elastic_beats_repo']['version'].split('.')[0]
  apt_uri = "https://artifacts.elastic.co/packages/#{major_version}.x/apt"
  apt_key = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
end

if node['platform_family'] == 'debian'
  package 'apt-transport-https'

  if node['elastic_beats_repo']['setup_repo']
    apt_repository 'beats' do
      uri apt_uri
      key apt_key
      components node['elastic_beats_repo']['apt']['components']
      distribution node['elastic_beats_repo']['apt']['distribution']
      action node['elastic_beats_repo']['apt']['action']
    end
  end
else
  raise "platform_family #{node['platform_family']} not supported"
end
