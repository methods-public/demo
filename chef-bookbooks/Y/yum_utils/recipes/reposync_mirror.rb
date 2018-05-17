#
# Cookbook Name:: yum_utils
# Recipe:: reposync_mirror
#
# Copyright 2013-2017, whitestar
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

::Chef::Recipe.send(:include, PlatformUtils::PackageUtils)
::Chef::Recipe.send(:include, YumUtils::RepoUtils)

prefix = 'yum-reposync'
yum_mirror = node['yum_utils']['reposync_mirror']

reposync_sources, url_aliases = reposync_base_setup(
  yum_mirror['user'],
  yum_mirror['base_path'],
  yum_mirror['yum_conf'],
  yum_mirror['repos_dir'],
  yum_mirror['repo_ids'],
  yum_mirror['arch'],
  yum_mirror['url_alias_with_authority_part']
)

template "/usr/local/bin/#{prefix}-mirror" do
  source "usr/local/bin/#{prefix}-mirror"
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    reposync_sources: reposync_sources
  )
end

pkg = cron_pkg_name
resources(package: pkg) rescue package pkg do
  action :install
end

template "/etc/cron.d/#{prefix}-mirror" do
  source "etc/cron.d/#{prefix}-mirror"
  owner 'root'
  group 'root'
  mode '0644'
end

httpd_service = httpd_pkg_name
httpd_conf_path = nil

case node['platform_family']
when 'debian'
  httpd_conf_path = "/etc/#{httpd_service}/conf.d/#{prefix}-mirror"
when 'rhel'
  httpd_conf_path = "/etc/#{httpd_service}/conf.d/#{prefix}-mirror.conf"
end

pkg = httpd_service
resources(package: pkg) rescue package pkg do
  action :install
end

resources(service: httpd_service) rescue service httpd_service do
  action [:enable, :start]
  supports status: true, restart: true, reload: true
end

template httpd_conf_path do
  source "etc/apache2/conf.d/#{prefix}-mirror"
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    url_aliases: url_aliases
  )
  notifies :restart, "service[#{httpd_service}]"
end
