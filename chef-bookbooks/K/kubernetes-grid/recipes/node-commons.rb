#
# Cookbook Name:: kubernetes-grid
# Recipe:: node-commons
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

# http://kubernetes.io/docs/getting-started-guides/kubeadm/

::Chef::Recipe.send(:include, PlatformUtils::VirtUtils)

if node['kubernetes-grid']['docker-engine']['setup']
  include_recipe 'docker-grid::engine'
end

case node['platform_family']
when 'rhel'
=begin
  if container_guest_node?
    # TODO:
  end
=end
  disable_selinux = 'disable_selinux'
  resources(execute: disable_selinux) rescue execute disable_selinux do
    user 'root'
    command 'setenforce 0'
    not_if 'getenforce | grep -i \'\(disabled\|permissive\)\''
  end
  template '/etc/selinux/config' do
    source  'etc/selinux/config'
    owner 'root'
    group 'root'
    mode '0644'
  end

  execute 'yum_makecache_kubernetes' do
    user 'root'
    # import GPG keys simultaneously.
    command 'yum -q -y makecache --disablerepo=* --enablerepo=kubernetes'
    action :nothing
  end

  template '/etc/yum.repos.d/kubernetes.repo' do
    source  'etc/yum.repos.d/kubernetes.repo'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :run, 'execute[yum_makecache_kubernetes]', :immediately
  end
when 'debian'
  if container_guest_node?
    Chef::Log.warn(
      'This node is running in the Linux container, Chef installs the linux-image. ' \
      'See https://github.com/kubernetes/kubernetes/issues/39282'
    )
    kern_pkg = "linux-image-#{node['kernel']['release']}"
    resources(package: kern_pkg) rescue package kern_pkg do
      action :install
      # Unless the platform version of host and guest is same, this resource will fail.
      ignore_failure true
    end
  end

  [
    'curl',
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

  apt_repo_config = node['kubernetes-grid']['apt_repo']
  add_key_command = ''
  if !apt_repo_config['keyurl'].nil? && !apt_repo_config['keyurl'].empty?
    add_key_command = "curl -s #{apt_repo_config['keyurl']} | apt-key add -"
  elsif !apt_repo_config['keyserver'].nil? && !apt_repo_config['keyserver'].empty? \
    && !apt_repo_config['recv-keys'].nil? && !apt_repo_config['recv-keys'].empty?
    add_key_command = "apt-key adv --keyserver #{apt_repo_config['keyserver']} --recv-keys #{apt_repo_config['recv-keys']}"
  end

  execute 'apt-key_add_google_cloud_packages_key' do
    command add_key_command
    action :nothing
    not_if 'apt-key list | grep "Google Cloud Packages"'
  end

  template '/etc/apt/sources.list.d/kubernetes.list' do
    source  'etc/apt/sources.list.d/kubernetes.list'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :run, 'execute[apt-key_add_google_cloud_packages_key]', :before
    notifies :run, "execute[#{apt_get_update}]", :immediately
  end
=begin
  # Pinning Kubernetes version
  template '/etc/apt/preferences.d/kubernetes.pref' do
    source  'etc/apt/preferences.d/kubernetes.pref'
    owner 'root'
    group 'root'
    mode '0644'
  end
=end
end

[
  'kubelet',
  'kubernetes-cni',  # already required by kublet ...
].each {|pkg|
  resources(package: pkg) rescue package pkg do
    action :install
  end
}

service 'kubelet' do
  action [:start, :enable]
end
