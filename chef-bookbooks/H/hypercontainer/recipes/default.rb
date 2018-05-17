#
# Cookbook Name:: hypercontainer
# Recipe:: default
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

file_cache_path = Chef::Config['file_cache_path']
platform_family = node['platform_family']
install_flavor = node['hypercontainer']['install_flavor']
fallback_direct_download_install = node['hypercontainer']['fallback_direct_download_install']
expected_ver = node['hypercontainer']['package']['version'].slice(/^(\d+\.\d+\.\d+)-/, 1)
download_url_context = node['hypercontainer']['package']['download_url_context']
status_file = '/tmp/install_hypercontainer_status'

systemctl_daemon_reload = 'systemctl_daemon-reload'
resources(bash: systemctl_daemon_reload) rescue bash systemctl_daemon_reload do
  code <<-EOH
    systemctl daemon-reload
  EOH
  action :nothing
end

pkgs = [
  'curl',
]

case platform_family
#when 'rhel'
#   do nothing.
when 'debian'
  pkgs.push('libvirt0')

  case node['hypercontainer']['hypervisor']
  when 'qemu'
    pkgs.push('qemu')
  when 'xen'
    pkgs.push('xen-hypervisor-amd64')
  end
end

pkgs.each {|pkg|
  resources(package: pkg) rescue package pkg do
    action :install
  end
}

hc_pkgs = {
  'hypercontainer' => node['hypercontainer']['package']['hypercontainer'],
  'hyperstart' => node['hypercontainer']['package']['hyperstart'],
}
hc_pkg_file_paths = []
hc_pkgs.each {|pkg_name, pkg_file|
  pkg_file_path = "#{file_cache_path}/#{pkg_file}"
  hc_pkg_file_paths.push(pkg_file_path)

  remote_file pkg_file_path do
    source "#{download_url_context}/#{pkg_file}"
    owner 'root'
    group 'root'
    mode '0644'
    action :nothing
  end

  package pkg_name do
    provider Chef::Provider::Package::Rpm if platform_family == 'rhel'
    provider Chef::Provider::Package::Dpkg if platform_family == 'debian'
    source pkg_file_path
    action :nothing
    if pkg_name == 'hyperstart'
      notifies :enable, 'service[hyperd]', :delayed
      notifies :restart, 'service[hyperd]', :delayed
    end
  end
}

# install trigger
log 'install_hypercontainer_packages.' do
  action :nothing
  not_if "hyperctl version | grep #{expected_ver}"
  hc_pkg_file_paths.each {|pkg_file_path|
    notifies :create, "remote_file[#{pkg_file_path}]", :before
  }
  hc_pkgs.each {|pkg_name, pkg_file|
    notifies :upgrade, "package[#{pkg_name}]", :immediately
  }
end

if install_flavor == 'script'
  execute 'install_hypercontainer_by_script' do
    # `echo $?` (always success) for notifies
    command "curl -sSL https://hypercontainer.io/install | bash; echo $? > #{status_file}"
    action :run
    not_if "hyperctl version | grep #{expected_ver}"
    not_if { File.exist?('/usr/bin/hyperctl') } unless node['hypercontainer']['auto_upgrade']
    if fallback_direct_download_install
      ignore_failure true
      notifies :write, 'log[install_hypercontainer_packages.]', :immediately
    end
  end
elsif install_flavor == 'direct_download'
  log 'do_install_hypercontainer_packages.' do
    notifies :write, 'log[install_hypercontainer_packages.]', :immediately
  end
end

hyperd_opts = []
extra_options = node['hypercontainer']['daemon_extra_options']
hyperd_opts.push(extra_options) if !extra_options.nil? && !extra_options.empty?

directory '/etc/systemd/system/hyperd.service.d' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/systemd/system/hyperd.service.d/override.conf' do
  source  'etc/systemd/system/hyperd.service.d/override.conf'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    hyperd_opts: hyperd_opts
  )
  notifies :run, "bash[#{systemctl_daemon_reload}]", :immediately
  notifies :restart, 'service[hyperd]'
end

template '/etc/hyper/config' do
  source  'etc/hyper/config'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[hyperd]'
end

srv = 'hyperd'
resources(service: srv) rescue service srv do
  action [:enable, :start]
  # waiting fallback installation.
  only_if { File.exist?('/usr/bin/hyperctl') }
end
