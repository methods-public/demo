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

# Configure systemd unit
systemd_unit 'fail2ban.service' do
  content node[cookbook_name]['systemd_unit']
  action :create
  not_if { node[cookbook_name]['systemd_unit'].empty? }
end

# Enable/Start service
service 'fail2ban' do
  action %i[enable start]
end
