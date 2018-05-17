#
# Cookbook:: yum-chef
# Recipe:: default
#
# Author:: Joshua Timberman <joshua@chef.io>
# Copyright:: 2015-2017, Chef Software, Inc. <legal@chef.io>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

yum_repository node['yum-chef']['repositoryid'] do
  description "Chef Software Inc #{node['yum-chef']['repositoryid']} repository"
  node['yum-chef'].each_pair do |opt, val|
    next if opt == 'repositoryid'
    send(opt.to_sym, val) unless val.nil?
  end
  sslverify node['yum-chef']['sslverify']
  gpgcheck node['yum-chef']['gpgcheck']
  action :create
end