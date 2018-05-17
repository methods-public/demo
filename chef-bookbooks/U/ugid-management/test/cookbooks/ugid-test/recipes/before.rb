#
# Copyright (c) 2016 Sam4Mobile, 2017-2018 Make.org
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

# Create a system user with its group
group 'create user_a' do
  group_name 'user_a'
  system true
end
user 'user_a' do
  group 'user_a'
  system true
end

# Install rpm creating a user (in 9XX range)
# Use package_name instead of resource name
package 'install chrony' do
  package_name 'chrony'
  retries 1
end

# Install a rpm creating a user (in XX range)
package 'bind' do
  retries 1
end

# Create an user directly (declared so should be ok)
execute 'useradd foobarbefore -g 100' do
  not_if 'cat /etc/passwd | grep foobarbefore:'
end

# Undeclared, should report an error
execute 'useradd errorbefore' do
  not_if 'cat /etc/passwd | grep errorbefore:'
end

# Create a group (declared so should be ok)
execute 'groupadd -g 2400 team' do
  not_if 'cat /etc/group | grep team:'
end

# Create an undeclared group
execute 'groupadd -g 2500 failgroup' do
  not_if 'cat /etc/group | grep failgroup:'
end
