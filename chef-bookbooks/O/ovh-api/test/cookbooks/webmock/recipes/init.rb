#
# Copyright (c) 2015-2017 Sam4Mobile, 2017-2018 Make.org
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

# Depends on webmock gem for our tests
chef_gem 'webmock' do
  compile_time true
end
require 'webmock'
::Chef::Recipe.send(:include, ::WebMock::API)
WebMock.enable!

# Monkey patch getifipv4s to include fake ifaces and ips
::Chef::Recipe.send(:include, ::OVHAPI)

module ::OVHAPI # rubocop:disable Style/ClassAndModuleChildren
  alias ifipv4_official ifipv4

  def ifipv4(ifaddrs)
    [['fake', '1.2.3.4']] + ifipv4_official(ifaddrs) << ['eth0', '5.6.7.8']
  end
end
