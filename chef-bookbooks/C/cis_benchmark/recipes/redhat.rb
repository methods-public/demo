#
# Cookbook Name:: cis_benchmark
# Recipe:: redhat
#
# Copyright 2011, Joshua Timberman
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

case node['platform']
when "redhat", "centos", "fedora", "scientifc"
  
  directory "/root" do
    owner "root"
    group "root"
    mode 0700
  end

  include_recipe "cis_benchmark::redhat_ssh"
  include_recipe "cis_benchmark::redhat_minimize_boot"
  include_recipe "cis_benchmark::redhat_sysacct"
  include_recipe "cis_benchmark::redhat_sysctl"
  include_recipe "cis_benchmark::redhat_permissions"
  include_recipe "cis_benchmark::redhat_cron_allow"
  include_recipe "cis_benchmark::redhat_banner"
  

else

  Chef::Log.warn("Platform #{node['platform']} is not supported at this time.")
  return

end

