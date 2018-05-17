#
# Cookbook:: desalination
# Recipe:: redhat
#
# Copyright:: 2018, Jon Middleton
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

service 'salt-minion' do
  action [:stop, :disable]
end

package 'salt-minion' do
  action :remove
end

package 'salt' do
  action :remove
end

directory '/etc/salt' do
  action :delete
  recursive true
end

package 'salt-repo' do
  action :remove
end
