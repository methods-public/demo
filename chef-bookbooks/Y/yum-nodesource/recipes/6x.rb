#
# Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)
# Cookbook Name:: yum-nodesource
# Recipe:: 6x
#
# Copyright 2017, Movile
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

yum_repository 'nodesource_6x' do
  description node['yum']['nodesource_6x']['description'] unless node['yum']['nodesource_6x']['description'].nil?
  baseurl node['yum']['nodesource_6x']['baseurl'] unless node['yum']['nodesource_6x']['baseurl'].nil?
  mirrorlist node['yum']['nodesource_6x']['mirrorlist'] unless node['yum']['nodesource_6x']['mirrorlist'].nil?
  gpgcheck node['yum']['nodesource_6x']['gpgcheck'] unless node['yum']['nodesource_6x']['gpgcheck'].nil?
  gpgkey node['yum']['nodesource_6x']['gpgkey'] unless node['yum']['nodesource_6x']['gpgkey'].nil?
  enabled node['yum']['nodesource_6x']['enabled'] unless node['yum']['nodesource_6x']['enabled'].nil?
  cost node['yum']['nodesource_6x']['cost'] unless node['yum']['nodesource_6x']['cost'].nil?
  exclude node['yum']['nodesource_6x']['exclude'] unless node['yum']['nodesource_6x']['exclude'].nil?
  enablegroups node['yum']['nodesource_6x']['enablegroups'] unless node['yum']['nodesource_6x']['enablegroups'].nil?
  failovermethod node['yum']['nodesource_6x']['failovermethod'] unless node['yum']['nodesource_6x']['failovermethod'].nil?
  http_caching node['yum']['nodesource_6x']['http_caching'] unless node['yum']['nodesource_6x']['http_caching'].nil?
  include_config node['yum']['nodesource_6x']['include_config'] unless node['yum']['nodesource_6x']['include_config'].nil?
  includepkgs node['yum']['nodesource_6x']['includepkgs'] unless node['yum']['nodesource_6x']['includepkgs'].nil?
  keepalive node['yum']['nodesource_6x']['keepalive'] unless node['yum']['nodesource_6x']['keepalive'].nil?
  max_retries node['yum']['nodesource_6x']['max_retries'] unless node['yum']['nodesource_6x']['max_retries'].nil?
  metadata_expire node['yum']['nodesource_6x']['metadata_expire'] unless node['yum']['nodesource_6x']['metadata_expire'].nil?
  mirror_expire node['yum']['nodesource_6x']['mirror_expire'] unless node['yum']['nodesource_6x']['mirror_expire'].nil?
  priority node['yum']['nodesource_6x']['priority'] unless node['yum']['nodesource_6x']['priority'].nil?
  proxy node['yum']['nodesource_6x']['proxy'] unless node['yum']['nodesource_6x']['proxy'].nil?
  proxy_username node['yum']['nodesource_6x']['proxy_username'] unless node['yum']['nodesource_6x']['proxy_username'].nil?
  proxy_password node['yum']['nodesource_6x']['proxy_password'] unless node['yum']['nodesource_6x']['proxy_password'].nil?
  repositoryid node['yum']['nodesource_6x']['repositoryid'] unless node['yum']['nodesource_6x']['repositoryid'].nil?
  sslcacert node['yum']['nodesource_6x']['sslcacert'] unless node['yum']['nodesource_6x']['sslcacert'].nil?
  sslclientcert node['yum']['nodesource_6x']['sslclientcert'] unless node['yum']['nodesource_6x']['sslclientcert'].nil?
  sslclientkey node['yum']['nodesource_6x']['sslclientkey'] unless node['yum']['nodesource_6x']['sslclientkey'].nil?
  sslverify node['yum']['nodesource_6x']['sslverify'] unless node['yum']['nodesource_6x']['sslverify'].nil?
  timeout node['yum']['nodesource_6x']['timeout'] unless node['yum']['nodesource_6x']['timeout'].nil?
  action :create
end
