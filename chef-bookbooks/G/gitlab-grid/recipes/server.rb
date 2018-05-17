#
# Cookbook Name:: gitlab-grid
# Recipe:: server
#
# Copyright 2017, whitestar
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

# https://about.gitlab.com/downloads/

#::Chef::Recipe.send(:include, PlatformUtils::VirtUtils)

include_recipe 'gitlab-grid::commons'

#config = node['gitlab-grid']['gitlab.rb']
#override_config = node.override['gitlab-grid']['gitlab.rb']
#force_override_config = node.force_override['gitlab-grid']['gitlab.rb']

case node['platform_family']
when 'rhel'
  [
    'curl',
    'policycoreutils',
    'openssh-server',
    'openssh-clients',
    'postfix',
  ].each {|pkg|
    resources(package: pkg) rescue package pkg do
      action :install
    end
  }

  [
    #'sshd',
    'postfix',
  ].each {|srv|
    resources(service: srv) rescue service srv do
      action [:enable, :start]
    end
  }

  bash 'update_firewall' do
    code <<-EOH
      firewall-cmd --permanent --add-service=http
      systemctl reload firewalld
    EOH
    action :run
    only_if 'systemctl is-enabled firewalld.service'
  end

  execute 'add_yum_repo_gitlab-ce' do
    command 'curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash'
    action :run
    not_if { File.exist?('/etc/yum.repos.d/gitlab_gitlab-ce.repo') }
  end
when 'debian'
  [
    'curl',
    'openssh-server',
    'ca-certificates',
    'postfix',
  ].each {|pkg|
    resources(package: pkg) rescue package pkg do
      action :install
    end
  }

  apt_get_update = 'apt-get_update'
  resources(execute: apt_get_update) rescue execute apt_get_update do
    command 'apt-get update'
    action :nothing
  end

  execute 'add_apt_source_gitlab-ce' do
    command 'curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash'
    action :run
    not_if { File.exist?('/etc/apt/sources.list.d/gitlab_gitlab-ce.list') }
    notifies :run, "execute[#{apt_get_update}]", :immediately
  end
end

[
  'gitlab-ce',
].each {|pkg|
  resources(package: pkg) rescue package pkg do
    action :install
  end
}

template '/etc/gitlab/gitlab.rb' do
  source  'etc/gitlab/gitlab.rb'
  owner 'root'
  group 'root'
  mode '0600'
  action :create
end

log <<-"EOM"
Note: You must execute the following command manually if the gitlab.rb file has been updated.
  $ sudo gitlab-ctl reconfigure
EOM
