#
# Cookbook Name:: yum_utils
# Recipe:: mirror
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

mirror_user = node['yum_utils']['mirror']['user']
base_path = node['yum_utils']['mirror']['base_path']

create_mirror_user(mirror_user, base_path)
create_mirror_dirs(mirror_user, base_path)

httpd_service = httpd_pkg_name
httpd_conf_path = nil

case node['platform_family']
when 'debian'
  httpd_conf_path = case node['platform_version'].to_i
                    when 8
                      "/etc/#{httpd_service}/conf-available/yum-mirror.conf"
                    else
                      "/etc/#{httpd_service}/conf.d/yum-mirror"
                    end
when 'rhel'
  httpd_conf_path = "/etc/#{httpd_service}/conf.d/yum-mirror.conf"
end

pkg = 'rsync'
resources(package: pkg) rescue package pkg do
  action :install
end

pkg = cron_pkg_name
resources(package: pkg) rescue package pkg do
  action :install
end

rsync_sources = []
node['yum_utils']['mirror']['rsync_sources'].each {|source|
  local_path = "#{base_path}/mirror/#{source['url'].gsub(%r{^rsync://}, '')}"
  local_path.end_with?('/') && local_path.chop!
  directory local_path do
    owner mirror_user
    group mirror_user
    mode '0755'
    recursive true
  end

  src = {
    'http_alias' => source['http_alias'],
    'local_path' => local_path,
    'rsync_command' => "rsync #{source['rsync_opts']} #{source['url']} #{local_path}/",
  }
  rsync_sources.push(src)
}

template '/usr/local/bin/yum-mirror' do
  source 'usr/local/bin/yum-mirror'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    rsync_sources: rsync_sources
  )
end

template '/etc/cron.d/yum-mirror' do
  source 'etc/cron.d/yum-mirror'
  owner 'root'
  group 'root'
  mode '0644'
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
  source 'etc/apache2/conf.d/yum-mirror'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    rsync_sources: rsync_sources
  )
  notifies :restart, "service[#{httpd_service}]"
end
