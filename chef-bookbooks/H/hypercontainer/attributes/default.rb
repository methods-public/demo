#
# Cookbook Name:: hypercontainer
# Attributes:: default
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

platform = node['platform']

#default['hypercontainer']['with_ssl_cert_cookbook'] = false
#default['hypercontainer']['ssl_cert']['common_name'] = node['fqdn']

default['hypercontainer']['install_flavor'] = 'script'  # 'script' or 'direct_download'
default['hypercontainer']['fallback_direct_download_install'] = true
default['hypercontainer']['package']['version'] = '1.0.0-1'
ver = node['hypercontainer']['package']['version']
ver_ctx = ver.slice(/^(\d+\.\d+)\./, 1)  # e.g. '0.8'
pf_ctx = \
  if ver_ctx >= '1.0' && (platform == 'debian' || platform == 'ubuntu')
    'debian_or_ubuntu'
  else
    platform
  end
default['hypercontainer']['package']['download_url_context'] \
  = "https://hypercontainer-download.s3-us-west-1.amazonaws.com/#{ver_ctx}/#{pf_ctx}"

case platform
when 'centos'
  default['hypercontainer']['package']['hypercontainer'] = "hyper-container-#{ver}.el7.centos.x86_64.rpm"
  default['hypercontainer']['package']['hyperstart']     = "hyperstart-#{ver}.el7.centos.x86_64.rpm"
when 'debian', 'ubuntu'
  default['hypercontainer']['package']['hypercontainer'] = "hypercontainer_#{ver}_amd64.deb"
  default['hypercontainer']['package']['hyperstart']     = "hyperstart_#{ver}_amd64.deb"
end

default['hypercontainer']['auto_upgrade'] = false
default['hypercontainer']['hypervisor'] = 'qemu'  # 'qemu' or 'xen' for Debian family.
default['hypercontainer']['daemon_extra_options'] = '--log_dir=/var/log/hyper'
default['hypercontainer']['config'] = {
  'global' => {
    'Kernel' => '/var/lib/hyper/kernel',
    'Initrd' => '/var/lib/hyper/hyper-initrd.img',
    'VmFactoryPolicy' => '',
  },
  'Log' => {
  },
}
