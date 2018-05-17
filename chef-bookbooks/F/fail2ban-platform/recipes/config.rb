#
# Copyright (c) 2018 Make.org
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

config = node[cookbook_name]['config']
config_dir = node[cookbook_name]['config_dir']
auto_restart = node[cookbook_name]['auto_restart']

# Deploy Fail2Ban configuration
config.each do |dir, files|
  next if files.nil?
  files.each do |filename, conf|
    file_path = "#{config_dir}/#{dir}.d/#{filename}"
    conf_ini = systemd_unit file_path do
      content conf
      action :nothing
    end.to_ini

    # We assumed creation of directories is done during package installation.
    header = '# Produced by Chef -- changes will be overwritten'
    file file_path do
      content "#{header}\n#{conf_ini}"
      mode '0644'
      notifies :restart, 'service[fail2ban]', :delayed if auto_restart
    end
  end
end
