#
# Cookbook Name:: chef_newrelic_server
# Recipe:: default
#
# Copyright 2015, Faizal F Zakaria
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node["platform"]
when "debian", "ubuntu"
  # Apt
  include_recipe 'apt'

  apt_repository 'newrelic' do
    uri 'http://apt.newrelic.com/debian/'
    distribution 'newrelic'
    components [ 'non-free' ]
    key 'http://download.newrelic.com/548C16BF.gpg'
  end
when "redhat", "centos", "amazon", "scientific"
  # Yum, support only 64 bits
  execute 'install-newrelic-sysmond' do
    command "rpm -Uvh --replacepkgs https://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm"
    action :run
  end
else
  return
end

package 'newrelic-sysmond'

execute 'set-newrelic-license-key' do
  command "nrsysmond-config --set license_key=#{node['newrelic_server']['license_key']}"
  action :run
end

service 'newrelic-sysmond' do
  action :start
end
