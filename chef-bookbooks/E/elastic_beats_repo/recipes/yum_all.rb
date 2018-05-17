#
# Cookbook Name:: elastic_beats_repo
# Recipe:: yum_all
#
# Copyright 2017, Virender Khatri
#

# filebeat repository attributes
yum_baseurl_v1 = 'https://packages.elastic.co/beats/yum/el/$basearch'
yum_gpgkey_v1 = 'https://packages.elastic.co/GPG-KEY-elasticsearch'
yum_baseurl_v5 = 'https://artifacts.elastic.co/packages/5.x/yum'
yum_gpgkey_v5 = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'

case node['platform_family']
when 'fedora', 'rhel', 'amazon'
  if node['elastic_beats_repo']['setup_repo']
    yum_repository 'beatsv1' do
      baseurl yum_baseurl_v1
      gpgkey yum_gpgkey_v1
      gpgcheck node['elastic_beats_repo']['yum']['gpgcheck']
      description node['elastic_beats_repo']['yum']['description']
      enabled node['elastic_beats_repo']['yum']['enabled']
      metadata_expire node['elastic_beats_repo']['yum']['metadata_expire']
      priority node['elastic_beats_repo']['yum']['priority'] if node['elastic_beats_repo']['yum']['priority']
      action node['elastic_beats_repo']['yum']['action']
    end

    yum_repository 'beatsv5' do
      baseurl yum_baseurl_v5
      gpgkey yum_gpgkey_v5
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
