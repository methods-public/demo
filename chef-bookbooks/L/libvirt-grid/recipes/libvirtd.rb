#
# Cookbook Name:: libvirt-grid
# Recipe:: libvirtd
#
# Copyright 2018, whitestar
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

platform_family = node['platform_family']

pkgs = []

case platform_family
when 'debian'
  pkgs += [
    'libvirt-bin',
    'qemu-kvm',
  ]
when 'rhel'
  pkgs += [
    'libvirt',
    'qemu-kvm',
  ]
end

pkgs.each {|pkg|
  resources(package: pkg) rescue package pkg do
    action :install
  end
}

service 'libvirtd' do
  action [:start, :enable]
end
