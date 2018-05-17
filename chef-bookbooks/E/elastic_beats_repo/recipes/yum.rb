#
# Cookbook Name:: elastic_beats_repo
# Recipe:: yum
#
# Copyright 2017, Virender Khatri
#

# filebeat repository attributes
if node['elastic_beats_repo']['version'] < '5.0'
  yum_baseurl = 'https://packages.elastic.co/beats/yum/el/$basearch'
  yum_gpgkey = 'https://packages.elastic.co/GPG-KEY-elasticsearch'
else
  major_version = node['elastic_beats_repo']['version'].split('.')[0]
  yum_baseurl = "https://artifacts.elastic.co/packages/#{major_version}.x/yum"
  yum_gpgkey = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
end

case node['platform_family']
when 'fedora', 'rhel', 'amazon'
  if node['elastic_beats_repo']['setup_repo']
    yum_repository 'beats' do
      baseurl yum_baseurl
      gpgkey yum_gpgkey
      gpgcheck node['elastic_beats_repo']['yum']['gpgcheck']
      description node['elastic_beats_repo']['yum']['description']
      enabled node['elastic_beats_repo']['yum']['enabled']
      metadata_expire node['elastic_beats_repo']['yum']['metadata_expire']
      priority node['elastic_beats_repo']['yum']['priority'] if node['elastic_beats_repo']['yum']['priority']
      action node['elastic_beats_repo']['yum']['action']
    end
  end
else
  raise "platform_family #{node['platform_family']} not supported"
end
