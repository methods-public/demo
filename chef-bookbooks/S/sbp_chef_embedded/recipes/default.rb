#
# Author:: Sander van Harmelen <svanharmelen@schubergphilis.com>
# Cookbook Name:: sbp_chef_embedded
# Recipe:: default
#
# Copyright 2014, Schuberg Philis
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

if node['chef_embedded']['enabled'] && (not platform_family?('windows'))
  if platform_family?('mac_os_x')
    template '/etc/paths.d/chef-embedded-bin.sh' do
      source 'chef-embedded-bin.sh.erb'
      mode 0644
      variables(:embedded_dir => Chef::Config.embedded_dir)
    end
  else
    template '/etc/profile.d/chef-embedded-bin.sh' do
      source 'chef-embedded-bin.sh.erb'
      mode 0644
      variables(:embedded_dir => Chef::Config.embedded_dir)
    end
  end
end
