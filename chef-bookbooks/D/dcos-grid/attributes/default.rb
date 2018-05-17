#
# Cookbook Name:: dcos-grid
# Attributes:: default
#
# Copyright 2016, whitestar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'uri'
require 'pathname'

default['dcos-grid']['dcos_release_url'] = 'https://downloads.dcos.io/dcos/stable/dcos_generate_config.sh'
default['dcos-grid']['dcos_release_checksum'] = nil
# DC/OS 1.8.7
#default['dcos-grid']['dcos_release_checksum'] = 'ddd9a86e4fc6ab149fb6c2ce38fc7d7c2f5891e62fb5ed41b91c3e99e02ed536'
default['dcos-grid']['dcos_release_script_name'] = Pathname(URI(node['dcos-grid']['dcos_release_url']).path).basename
default['dcos-grid']['cli']['version'] = '0.4.14'  # or dcos-1.8
default['dcos-grid']['dcos_cli_release_url'] = "https://downloads.dcos.io/binaries/cli/linux/x86-64/#{node['dcos-grid']['cli']['version']}/dcos"
default['dcos-grid']['dcos_cli_upgrade'] = false
default['dcos-grid']['cli']['release_url'] = node['dcos-grid']['dcos_cli_release_url']
default['dcos-grid']['cli']['release_checksum'] = nil
# DC/OS CLI 0.4.14
#default['dcos-grid']['cli']['release_checksum'] = '070587062c7c0b926e2438a383b05c942e99ccf909421feed4941d06e3846fa7'
default['dcos-grid']['cli']['auto_upgrade'] = node['dcos-grid']['dcos_cli_upgrade']
default['dcos-grid']['cli']['install_path'] = '/usr/local/bin/dcos'
# DEPRECATED: ['dcos-grid']['docker'][*] attributes. Use ['docker-grid'][*]
default['dcos-grid']['docker']['apt_repo'] = {
  'url' => nil,
  'keyserver' => nil,
  'recv-keys' => nil,
}
default['dcos-grid']['docker']['yum_repo'] = {
  'baseurl' => nil,
  'gpgcheck' => nil,
  'gpgkey' => nil,
}
# DEPRECATED: ['dcos-grid']['docker-engine'][*] attributes except for ['dcos-grid']['docker-engine']['setup']
#   Use ['docker-grid']['engine'][*]
default['dcos-grid']['docker-engine']['setup'] = true
default['dcos-grid']['docker-engine']['version_on_centos'] = nil
default['dcos-grid']['docker-engine']['version_on_ubuntu'] = nil
default['dcos-grid']['docker-engine']['version'] = nil
default['dcos-grid']['docker-engine']['storage-driver_on_centos'] = nil
default['dcos-grid']['docker-engine']['storage-driver_on_ubuntu'] = nil
default['dcos-grid']['docker-engine']['storage-driver'] = nil
default['dcos-grid']['docker-engine']['daemon_extra_options'] = nil
default['dcos-grid']['bootstrap']['ip'] = '127.0.0.1'
default['dcos-grid']['bootstrap']['port'] = '8080'
default['dcos-grid']['bootstrap']['genconf_dir'] = '/opt/dcos-grid/genconf'
default['dcos-grid']['bootstrap']['config'] = {
  'bootstrap_url' => "http://#{node['dcos-grid']['bootstrap']['ip']}:#{node['dcos-grid']['bootstrap']['port']}",
  'cluster_name' => 'dcos0',
  'exhibitor_storage_backend' => 'static',
  'ip_detect_filename' => '/genconf/ip-detect',
  'master_discovery' => 'static',
  'master_list' => [
    #'192.168.56.101',
    #'192.168.56.102',
    #'192.168.56.103',
  ],
  'oauth_auth_host' => 'https://dcos.auth0.com',
  'oauth_auth_redirector' => 'https://auth.dcos.io',
  'oauth_available' => 'true',
  'oauth_enabled' => 'true',
  'oauth_issuer_url' => 'https://dcos.auth0.com/',
  'resolvers' => [
    #'8.8.8.8',
    #'8.8.4.4',
  ],
  'telemetry_enabled' => 'false',
}
default['dcos-grid']['bootstrap']['ip-detect'] = {
  'interface' => 'eth0',
}
default['dcos-grid']['node']['auto_setup'] = false
default['dcos-grid']['cloud-config'] = {
  'target_platform' => 'coreos',  # coreos only now.
  'target_dir' => '/home/core',
  'target_owner' => 'core:core',
  'hostname' => '<fqdn>',
  'timezone' => 'Etc/GMT',
  'ssh_authorized_keys' => [
    '<your_ssh_pub_key>',
  ],
}
default['dcos-grid']['universe-server']['docker-compose']['app_dir'] = '/opt/docker-compose/app/dcos-universe'
# ./docker-compose.yml
default['dcos-grid']['universe-server']['docker-compose']['config'] = {
  'version' => '2',
  'services' => {
    'universe' => {
      #'image' => 'mesosphere/universe-server:20161211T190517Z-pull-863-c51dcb3955',
      #'ports' => [
      #  '8085:80',
      #],
    },
  },
}
