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
# limitations under the Li%w()
#

# Install ssh client/server and sshpass tool
package ['openssh-server', 'openssh-clients', 'sshpass']

# Enable/Start ssh service
service 'sshd' do
  action :start
end

# Attempt to SSH with false password
execute 'ssh_attempt' do
  command 'sshpass -p badpass ssh -o StrictHostKeyChecking=no localhost'
  returns 5
end
