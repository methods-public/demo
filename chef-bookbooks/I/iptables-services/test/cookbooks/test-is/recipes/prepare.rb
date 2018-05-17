#
# Copyright (c) 2017-2018 Make.org
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

cmds = node[cookbook_name]['cmds']

unless system('systemctl status iptables > /dev/null')
  cmds.each do |cmd|
    execute "prepare iptables: #{cmd}" do
      command cmd
      action :nothing
    end.run_action(:run)
  end
end
