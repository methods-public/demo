#
# Cookbook Name:: qpid
# Recipe:: server
#
# Copyright 2014, Marius Karnauskas
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

%w(qpid-cpp-server qpid-tools).each do |p|
  package p do
    action :install
  end
end

# directory '/etc/qpid' do
#     owner 'root'
#     group 'root'
#     mode '0755'
# end
#
# directory '/var/lib/qpidd' do
#     owner node['qpid']['user']
#     group node['qpid']['group']
#     mode '0750'
# end

template '/etc/qpid/qpidc.conf' do
  source 'qpidc.conf.erb'
  variables conf: node['qpid']['qpidc']
end

template '/etc/qpid/qpidd.conf' do
  source 'qpidd.conf.erb'
  variables conf: node['qpid']['qpidc']
end

template '/etc/sasl2/qpidd.conf' do
  source 'sasl_qpidd.conf.erb'
end

service 'qpidd' do
  action [:enable, :start]
end
