#
# Author:: Chase Bolt (<chase.bolt@gmail.com>)
# Recipe:: yum-rabbitmq::default
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

%w(
  rabbitmq
  rabbitmq-erlang
).each do |repo|
  yum_repository repo do
    next unless node['yum'][repo]['managed']
    node['yum'][repo].each do |config, value|
      next if config == 'managed'
      send(config.to_sym, value) unless value.nil?
    end
    action :create
  end
end
