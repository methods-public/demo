#
# Cookbook Name:: cdap
# Attribute:: services
#
# Copyright © 2015-2017 Cask Data, Inc.
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

name = 'kafka'
default['cdap'][name]['user'] = 'cdap'
default['cdap'][name]['init_name'] = 'Kafka Server'
default['cdap'][name]['init_krb5'] = false
default['cdap'][name]['init_cmd'] =
  if node['cdap']['version'].to_f < 4.0
    "/opt/cdap/#{name}/bin/svc-#{name}-server"
  else
    "/opt/cdap/#{name}/bin/cdap #{name}-server"
  end
default['cdap'][name]['init_actions'] = [:nothing]

name = 'master'
default['cdap'][name]['user'] = 'cdap'
default['cdap'][name]['init_name'] = name.split.map(&:capitalize).join(' ')
default['cdap'][name]['init_krb5'] = true

name = 'router'
default['cdap'][name]['user'] = 'cdap'
default['cdap'][name]['init_name'] = name.split.map(&:capitalize).join(' ')
default['cdap'][name]['init_krb5'] = false
default['cdap'][name]['init_cmd'] =
  if node['cdap']['version'].to_f < 4.0
    "/opt/cdap/gateway/bin/svc-#{name}"
  else
    "/opt/cdap/gateway/bin/cdap #{name}"
  end
default['cdap'][name]['init_actions'] = [:nothing]

name = 'security'
default['cdap'][name]['user'] = 'cdap'
default['cdap'][name]['init_name'] = 'Auth Server'
default['cdap'][name]['init_krb5'] = false
default['cdap'][name]['init_cmd'] =
  if node['cdap']['version'].to_f < 4.0
    "/opt/cdap/#{name}/bin/svc-auth-server"
  else
    "/opt/cdap/#{name}/bin/cdap auth-server"
  end
default['cdap'][name]['init_actions'] = [:nothing]

name = 'ui'
default['cdap'][name]['user'] = 'cdap'
default['cdap'][name]['init_name'] = name.upcase
default['cdap'][name]['init_krb5'] = false

%w(master ui).each do |svc|
  default['cdap'][svc]['init_cmd'] =
    if node['cdap']['version'].to_f < 4.0
      "/opt/cdap/#{svc}/bin/svc-#{svc}"
    else
      "/opt/cdap/#{svc}/bin/cdap #{svc}"
    end
  default['cdap'][svc]['init_actions'] = [:nothing]
end
