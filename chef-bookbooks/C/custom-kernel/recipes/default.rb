#
# Copyright (c) 2017 Make.org
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

config = node[cookbook_name]

%w[headers kernel].each do |type|
  remote_file "#{Chef::Config[:file_cache_path]}/#{config["#{type}_rpm"]}" do
    source "#{config['base_url']}/#{config["#{type}_rpm"]}"
    checksum config["#{type}_checksum"]
    not_if { config["#{type}_checksum"].empty? }
    notifies :install, "rpm_package[#{config["#{type}_rpm"]}]", :immediately
  end
end

rpm_package config['headers_rpm'] do
  source "#{Chef::Config[:file_cache_path]}/#{config['headers_rpm']}"
  action :nothing
end

rpm_package config['kernel_rpm'] do # ~FC037
  source "#{Chef::Config[:file_cache_path]}/#{config['kernel_rpm']}"
  notifies :run, 'execute[regenerate initramfs]', :immediately
  notifies :run, "execute[#{cookbook_name}: update grub]", :immediately
  notifies config['reboot_action'], 'reboot[kernel_update]', :immediately
  action :nothing
end

execute 'regenerate initramfs' do
  command <<-BASH
    dracut /boot/initramfs-#{config['version']}.img #{config['version']}
  BASH
  creates "/boot/initramfs-#{config['version']}.img"
  action :run
end

execute "#{cookbook_name}: update grub" do
  command <<-BASH
    grub2-set-default 0
    grub2-mkconfig -o /boot/grub2/grub.cfg
  BASH
  action :nothing
end

reboot 'kernel_update' do
  reason 'Need to reboot with new kernel'
  action :nothing
  delay_mins 1
end
