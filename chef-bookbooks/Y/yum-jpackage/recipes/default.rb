#
# Cookbook Name:: yum-jpackage
# Recipe:: default
#
# Copyright 2014, Mariani Lucas
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
yum_repository node['yum']['jpackage']['repositoryid'] do
  description node['yum']['jpackage']['description']
  baseurl node['yum']['jpackage']['baseurl']
  mirrorlist node['yum']['jpackage']['mirrorlist']
  gpgcheck node['yum']['jpackage']['gpgcheck']
  gpgkey node['yum']['jpackage']['gpgkey']
  enabled node['yum']['jpackage']['enabled']
  cost node['yum']['jpackage']['cost']
  exclude node['yum']['jpackage']['exclude']
  enablegroups node['yum']['jpackage']['enablegroups']
  failovermethod node['yum']['jpackage']['failovermethod']
  http_caching node['yum']['jpackage']['http_caching']
  include_config node['yum']['jpackage']['include_config']
  includepkgs node['yum']['jpackage']['includepkgs']
  keepalive node['yum']['jpackage']['keepalive']
  max_retries node['yum']['jpackage']['max_retries']
  metadata_expire node['yum']['jpackage']['metadata_expire']
  mirror_expire node['yum']['jpackage']['mirror_expire']
  priority node['yum']['jpackage']['priority']
  proxy node['yum']['jpackage']['proxy']
  proxy_username node['yum']['jpackage']['proxy_username']
  proxy_password node['yum']['jpackage']['proxy_password']
  repositoryid node['yum']['jpackage']['repositoryid']
  sslcacert node['yum']['jpackage']['sslcacert']
  sslclientcert node['yum']['jpackage']['sslclientcert']
  sslclientkey node['yum']['jpackage']['sslclientkey']
  sslverify node['yum']['jpackage']['sslverify']
  timeout node['yum']['jpackage']['timeout']
  action :create
  not_if { node['yum']['jpackage']['managed'] == false }
end
