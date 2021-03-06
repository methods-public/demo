# Cookbook Name:: netdata
# Resources:: netdata_bind_rndc_conf
#
# Copyright 2016, Abiquo
# Copyright 2017, Nick Willever
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

resource_name :netdata_bind_rndc_conf

default_action :create

property :conf_file, kind_of: String,
                     default: '/etc/netdata/python.d/bind_rndc.conf'
property :owner, kind_of: String, default: 'netdata'
property :group, kind_of: String, default: 'netdata'
property :named_stats_path, kind_of: String, default: nil

action :create do
  Chef::Log.warn 'Use of the resource `netdata_bind_rndc_conf` ' \
            'is now deprecated and will be removed in a future release. ' \
            'The resource `netdata_python_plugin` should be used instead.'

  netdata_python_plugin 'bind_rndc' do
    owner new_resource.owner
    group new_resource.group
    jobs(
      'local' => {
        'named_stats_path' => new_resource.named_stats_path,
      }
    )
  end
end
