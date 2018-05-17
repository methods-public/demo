#
# Cookbook Name:: gitlab_omnibus
# Recipe:: default
#
# Copyright 2015 Drew A. Blessing
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

if node['gitlab_omnibus']['use_packagecloud']
  case node['gitlab_omnibus']['edition']
  when 'community'
    packagecloud_repo 'gitlab/gitlab-ce' do
      base_url 'https://packages.gitlab.com'
      gpg_key_url 'https://package.gitlab.com/gpg.key'
    end

    node.default['gitlab_omnibus']['package_name'] = 'gitlab-ce'
  when 'enterprise'
    packagecloud_repo 'gitlab/gitlab-ee' do
      base_url 'https://packages.gitlab.com'
      gpg_key_url 'https://package.gitlab.com/gpg.key'
    end
    node.default['gitlab_omnibus']['package_name'] = 'gitlab-ee'
  end
end

# Low tech way to prevent unnecessary reconfigure and restart actions later on
first_install = !File.exist?('/opt/gitlab/bin/gitlab-ctl')

# gitlab_omnibus_package 'gitlab' do
package node['gitlab_omnibus']['package_name'] do
  action node['gitlab_omnibus']['action']
  version node['gitlab_omnibus']['version']

  # No need to reconfigure or restart on first install.
  unless first_install
    notifies :reconfigure, 'gitlab_omnibus_service[gitlab]'
    notifies :restart, 'gitlab_omnibus_service[gitlab]'
  end
end

template '/etc/gitlab/gitlab.rb' do
  source 'gitlab.rb.erb'
  mode '0640'

  # This is pretty crazy conditional logic just for reconfigure/restart
  # but there are lots of edge cases to cover.
  if first_install
    # Must reconfigure immediately on first install otherwise service will fail to start
    notifies :reconfigure, 'gitlab_omnibus_service[gitlab]', :immediately

    # If CI is enabled we need an extra reconfigure to generate oauth configuration
    # once CI and Gitlab are both up and running.
    if node['gitlab_omnibus']['registry_external_url']
      notifies :reconfigure, 'gitlab_omnibus_service[gitlab]'
    end
  else
    notifies :reconfigure, 'gitlab_omnibus_service[gitlab]'
    notifies :restart, 'gitlab_omnibus_service[gitlab]'
  end
end

gitlab_omnibus_service 'gitlab' do
  start_command '/opt/gitlab/bin/gitlab-ctl start'
  stop_command '/opt/gitlab/bin/gitlab-ctl stop'
  status_command '/opt/gitlab/bin/gitlab-ctl status'
  restart_command '/opt/gitlab/bin/gitlab-ctl restart'
  reconfigure_command '/opt/gitlab/bin/gitlab-ctl reconfigure'
  action :start
  supports restart: true, status: true
end

if node['gitlab_omnibus']['backup']['enable']
  include_recipe 'gitlab_omnibus::_backup'
end
