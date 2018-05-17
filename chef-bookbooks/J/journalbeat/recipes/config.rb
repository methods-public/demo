# Copyright (c) 2017 Make.org
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

# Create journalbeat config,data and logs directory
config = node[cookbook_name]['config'].to_hash
config_dir = config.dig('paths', 'path.config')
data_dir = config.dig('paths', 'path.data')
logs_dir = config.dig('paths', 'path.logs')
certs_dir = node[cookbook_name]['certs_dir']

[config_dir, data_dir, logs_dir, certs_dir].each do |dir|
  directory dir do
    user node[cookbook_name]['user']
    group node[cookbook_name]['group']
    recursive true
    mode '0755'
  end
end

# Retrieve remote logstash certificate authorities if needed and
# update ssl.certificate_authorities configuration accordingly
if config['output.logstash']['enabled']
  logstash_cas_uris = node[cookbook_name]['cas_uris']['logstash']
  unless logstash_cas_uris.nil?
    config['output.logstash']['ssl.certificate_authorities'] = []
    logstash_cas_uris.each do |ca_uri|
      ca_file = "#{certs_dir}/#{ca_uri.split('/').last}"
      remote_file ca_file do
        source ca_uri
        owner node[cookbook_name]['user']
        group node[cookbook_name]['group']
        mode '0755'
        action :create
      end
      config['output.logstash']['ssl.certificate_authorities'] << ca_file
    end
  end
end

# Deploy journalbeat configuration
config_file = node[cookbook_name]['config_file']
header = '# Produced by Chef -- changes will be overwritten'

auto_restart = node[cookbook_name]['auto_restart']
file "#{config_dir}/#{config_file}" do
  content "#{header}\n#{config.to_yaml}"
  owner node[cookbook_name]['user']
  group node[cookbook_name]['group']
  mode '0644'
  notifies :restart, 'systemd_unit[journalbeat.service]' if auto_restart
end
