#
# Cookbook Name:: elastic_beats_repo
# Recipe:: apt
#
# Copyright 2017, Virender Khatri
#

apt_uri_v1 = 'https://packages.elastic.co/beats/apt'
apt_key_v1 = 'https://packages.elastic.co/GPG-KEY-elasticsearch'
apt_uri_v5 = 'https://artifacts.elastic.co/packages/5.x/apt'
apt_key_v5 = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'

if node['platform_family'] == 'debian'
  package 'apt-transport-https'

  if node['elastic_beats_repo']['setup_repo']
    apt_repository 'beatsv1' do
      uri apt_uri_v1
      key apt_key_v1
      components node['elastic_beats_repo']['apt']['components']
      distribution node['elastic_beats_repo']['apt']['distribution']
      action node['elastic_beats_repo']['apt']['action']
    end

    apt_repository 'beatsv5' do
      uri apt_uri_v5
      key apt_key_v5
      components node['elastic_beats_repo']['apt']['components']
      distribution node['elastic_beats_repo']['apt']['distribution']
      action node['elastic_beats_repo']['apt']['action']
    end
  end
else
  raise "platform_family #{node['platform_family']} not supported"
end
