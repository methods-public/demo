#
# Author:: Hugo Cisneiros (hugo.cisneiros@movile.com)
# Cookbook Name:: cobbpass
# Attributes:: default
#
# Copyright 2017, Movile
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

default['yum']['grafana']['repositoryid'] = 'grafana'
default['yum']['grafana']['gpgkey'] = 'https://grafanarel.s3.amazonaws.com/RPM-GPG-KEY-grafana'
default['yum']['grafana']['description'] = 'Grafana RPM Repository'
default['yum']['grafana']['failovermethod'] = 'priority'
default['yum']['grafana']['gpgcheck'] = true
default['yum']['grafana']['enabled'] = true

case node['platform']
when "amazon"
  default['yum']['grafana']['baseurl'] = 'https://packagecloud.io/grafana/stable/el/6/$basearch'
else
  case node['platform_version'].to_i
  when 6
    default['yum']['grafana']['baseurl'] = 'https://packagecloud.io/grafana/stable/el/6/$basearch'
  when 7
    default['yum']['grafana']['baseurl'] = 'https://packagecloud.io/grafana/stable/el/7/$basearch'
  end
end
