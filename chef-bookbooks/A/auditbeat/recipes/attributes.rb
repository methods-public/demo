#
# Cookbook Name:: auditbeat
# Recipe:: attributes
#
# Copyright 2017, Virender Khatri
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

node.default['auditbeat']['conf_dir'] = if node['platform'] == 'windows'
                                          if node['auditbeat']['version'] < '5.0'
                                            "#{node['auditbeat']['windows']['base_dir']}/auditbeat-#{node['auditbeat']['version']}-windows"
                                          else
                                            "#{node['auditbeat']['windows']['base_dir']}/auditbeat-#{node['auditbeat']['version']}-windows-#{node['auditbeat']['arch']}"
                                          end
                                        else
                                          '/etc/auditbeat'
                                        end
node.default['auditbeat']['conf_file'] = if node['platform'] == 'windows'
                                           "#{node['auditbeat']['conf_dir']}/auditbeat.yml"
                                         else
                                           ::File.join(node['auditbeat']['conf_dir'], 'auditbeat.yml')
                                         end

node.default['auditbeat']['config']['auditbeat']['registry_file'] = if node['platform'] == 'windows'
                                                                      "#{node['auditbeat']['conf_dir']}/registry"
                                                                    else
                                                                      '/var/lib/auditbeat/registry'
                                                                    end

major_version = node['auditbeat']['version'].split('.')[0]
node.default['auditbeat']['yum']['baseurl'] = "https://artifacts.elastic.co/packages/#{major_version}.x/yum"
node.default['auditbeat']['yum']['gpgkey'] = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
node.default['auditbeat']['apt']['uri'] = "https://artifacts.elastic.co/packages/#{major_version}.x/apt"
node.default['auditbeat']['apt']['key'] = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
