#
# Copyright (c) 2016 Sam4Mobile
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

retries_number = node['galera-platform']['service']['retries_number']
retry_delay = node['galera-platform']['service']['retry_delay']

config_files = %w(/etc/my.cnf.d/server.cnf /root/.my.cnf)
config_files.map! { |path| "template[#{path}]" }

auto_restart = node['galera-platform']['auto_restart']

service 'mariadb' do
  action [:enable, :start]
  retries retries_number unless retries_number.nil?
  retry_delay retry_delay unless retry_delay.nil?
  subscribes :restart, config_files, :immediately if auto_restart
  only_if { File.exist?('/etc/my.cnf.d/cluster_bootstraped') }
end
