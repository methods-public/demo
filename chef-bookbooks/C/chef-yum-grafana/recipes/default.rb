#
# Author:: Hugo Cisneiros (<hugo.cisneiros@movile.com>)
# Cookbook Name:: yum-grafana
# Recipe:: default
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

yum_repository 'grafana' do
  description node['yum']['grafana']['description'] unless node['yum']['grafana']['description'].nil?
  baseurl node['yum']['grafana']['baseurl'] unless node['yum']['grafana']['baseurl'].nil?
  mirrorlist node['yum']['grafana']['mirrorlist'] unless node['yum']['grafana']['mirrorlist'].nil?
  gpgcheck node['yum']['grafana']['gpgcheck'] unless node['yum']['grafana']['gpgcheck'].nil?
  gpgkey node['yum']['grafana']['gpgkey'] unless node['yum']['grafana']['gpgkey'].nil?
  enabled node['yum']['grafana']['enabled'] unless node['yum']['grafana']['enabled'].nil?
  cost node['yum']['grafana']['cost'] unless node['yum']['grafana']['cost'].nil?
  exclude node['yum']['grafana']['exclude'] unless node['yum']['grafana']['exclude'].nil?
  enablegroups node['yum']['grafana']['enablegroups'] unless node['yum']['grafana']['enablegroups'].nil?
  failovermethod node['yum']['grafana']['failovermethod'] unless node['yum']['grafana']['failovermethod'].nil?
  http_caching node['yum']['grafana']['http_caching'] unless node['yum']['grafana']['http_caching'].nil?
  include_config node['yum']['grafana']['include_config'] unless node['yum']['grafana']['include_config'].nil?
  includepkgs node['yum']['grafana']['includepkgs'] unless node['yum']['grafana']['includepkgs'].nil?
  keepalive node['yum']['grafana']['keepalive'] unless node['yum']['grafana']['keepalive'].nil?
  max_retries node['yum']['grafana']['max_retries'] unless node['yum']['grafana']['max_retries'].nil?
  metadata_expire node['yum']['grafana']['metadata_expire'] unless node['yum']['grafana']['metadata_expire'].nil?
  mirror_expire node['yum']['grafana']['mirror_expire'] unless node['yum']['grafana']['mirror_expire'].nil?
  priority node['yum']['grafana']['priority'] unless node['yum']['grafana']['priority'].nil?
  proxy node['yum']['grafana']['proxy'] unless node['yum']['grafana']['proxy'].nil?
  proxy_username node['yum']['grafana']['proxy_username'] unless node['yum']['grafana']['proxy_username'].nil?
  proxy_password node['yum']['grafana']['proxy_password'] unless node['yum']['grafana']['proxy_password'].nil?
  repositoryid node['yum']['grafana']['repositoryid'] unless node['yum']['grafana']['repositoryid'].nil?
  sslcacert node['yum']['grafana']['sslcacert'] unless node['yum']['grafana']['sslcacert'].nil?
  sslclientcert node['yum']['grafana']['sslclientcert'] unless node['yum']['grafana']['sslclientcert'].nil?
  sslclientkey node['yum']['grafana']['sslclientkey'] unless node['yum']['grafana']['sslclientkey'].nil?
  sslverify node['yum']['grafana']['sslverify'] unless node['yum']['grafana']['sslverify'].nil?
  timeout node['yum']['grafana']['timeout'] unless node['yum']['grafana']['timeout'].nil?
  action :create
end
