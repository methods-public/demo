#
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

require 'spec_helper'

describe file('/etc/rundeck/realm.properties') do
  it { should contain('admin=password,admin,user') }
  it { should contain('user1=password1,group1,user') }
  it { should_not contain('user2=password2,group2,user') }
  it { should_not contain('user3=,group1,user') }
end

describe file('/etc/rundeck/nodes/rundeck-kitchen.yml') do
  it { should contain('hostname: rundeck-server-centos-7') }
  it { should contain('nodename: rundeck-server-centos-7') }
  it { should contain('username: rundeck') }
end

describe file('/etc/rundeck/nodes/role-without-node.yml') do
  it { should_not exist }
end
