#
# Cookbook Name:: hem
# Recipe:: default
#
# Copyright 2016 Inviqa UK Ltd
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

include_recipe 'apt' if node['platform_family'] == 'debian'
include_recipe 'git'
include_recipe 'vagrant'

yum_repository 'inviqa-tools' do
  description 'Inviqa Tools Repository - EL6 $basearch'
  baseurl 'https://dx6pc3giz7k1r.cloudfront.net/repos/el6/$basearch'
  enabled true
  gpgcheck true
  gpgkey 'https://dx6pc3giz7k1r.cloudfront.net/GPG-KEY-inviqa-tools'
  sslverify true
  action :create
  only_if { node['platform_family'] == 'rhel' }
end

apt_repository 'inviqa-tools' do
  uri 'https://dx6pc3giz7k1r.cloudfront.net/repos/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  key 'https://dx6pc3giz7k1r.cloudfront.net/GPG-KEY-inviqa-tools'
  action :add
  only_if { node['platform_family'] == 'debian' }
end

package 'hem' do
  action :install
end
