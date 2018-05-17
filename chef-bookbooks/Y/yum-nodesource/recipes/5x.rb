#
# Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)
# Cookbook Name:: yum-nodesource
# Recipe:: 5x
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

yum_repository 'nodesource_5x' do
  description node['yum']['nodesource_5x']['description'] unless node['yum']['nodesource_5x']['description'].nil?
  baseurl node['yum']['nodesource_5x']['baseurl'] unless node['yum']['nodesource_5x']['baseurl'].nil?
  mirrorlist node['yum']['nodesource_5x']['mirrorlist'] unless node['yum']['nodesource_5x']['mirrorlist'].nil?
  gpgcheck node['yum']['nodesource_5x']['gpgcheck'] unless node['yum']['nodesource_5x']['gpgcheck'].nil?
  gpgkey node['yum']['nodesource_5x']['gpgkey'] unless node['yum']['nodesource_5x']['gpgkey'].nil?
  enabled node['yum']['nodesource_5x']['enabled'] unless node['yum']['nodesource_5x']['enabled'].nil?
  cost node['yum']['nodesource_5x']['cost'] unless node['yum']['nodesource_5x']['cost'].nil?
  exclude node['yum']['nodesource_5x']['exclude'] unless node['yum']['nodesource_5x']['exclude'].nil?
  enablegroups node['yum']['nodesource_5x']['enablegroups'] unless node['yum']['nodesource_5x']['enablegroups'].nil?
  failovermethod node['yum']['nodesource_5x']['failovermethod'] unless node['yum']['nodesource_5x']['failovermethod'].nil?
  http_caching node['yum']['nodesource_5x']['http_caching'] unless node['yum']['nodesource_5x']['http_caching'].nil?
  include_config node['yum']['nodesource_5x']['include_config'] unless node['yum']['nodesource_5x']['include_config'].nil?
  includepkgs node['yum']['nodesource_5x']['includepkgs'] unless node['yum']['nodesource_5x']['includepkgs'].nil?
  keepalive node['yum']['nodesource_5x']['keepalive'] unless node['yum']['nodesource_5x']['keepalive'].nil?
  max_retries node['yum']['nodesource_5x']['max_retries'] unless node['yum']['nodesource_5x']['max_retries'].nil?
  metadata_expire node['yum']['nodesource_5x']['metadata_expire'] unless node['yum']['nodesource_5x']['metadata_expire'].nil?
  mirror_expire node['yum']['nodesource_5x']['mirror_expire'] unless node['yum']['nodesource_5x']['mirror_expire'].nil?
  priority node['yum']['nodesource_5x']['priority'] unless node['yum']['nodesource_5x']['priority'].nil?
  proxy node['yum']['nodesource_5x']['proxy'] unless node['yum']['nodesource_5x']['proxy'].nil?
  proxy_username node['yum']['nodesource_5x']['proxy_username'] unless node['yum']['nodesource_5x']['proxy_username'].nil?
  proxy_password node['yum']['nodesource_5x']['proxy_password'] unless node['yum']['nodesource_5x']['proxy_password'].nil?
  repositoryid node['yum']['nodesource_5x']['repositoryid'] unless node['yum']['nodesource_5x']['repositoryid'].nil?
  sslcacert node['yum']['nodesource_5x']['sslcacert'] unless node['yum']['nodesource_5x']['sslcacert'].nil?
  sslclientcert node['yum']['nodesource_5x']['sslclientcert'] unless node['yum']['nodesource_5x']['sslclientcert'].nil?
  sslclientkey node['yum']['nodesource_5x']['sslclientkey'] unless node['yum']['nodesource_5x']['sslclientkey'].nil?
  sslverify node['yum']['nodesource_5x']['sslverify'] unless node['yum']['nodesource_5x']['sslverify'].nil?
  timeout node['yum']['nodesource_5x']['timeout'] unless node['yum']['nodesource_5x']['timeout'].nil?
  action :create
end
