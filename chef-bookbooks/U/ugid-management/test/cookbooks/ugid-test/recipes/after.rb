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

# Create a user with its group
group 'user_b'

user 'create user_b' do
  username 'user_b'
  group 'user_b'
  shell '/bin/bash'
end

# Install rpm creating a user (in 9XX range)
package 'dovecot' do
  retries 1
end

# Install a package not creating a user
package 'which' do
  retries 1
end

# Install docker (which creates only the group docker and no ur)
include_recipe 'docker-platform::repository'
include_recipe 'docker-platform::package'

# Create an user directly (declared so should be ok)
execute 'useradd foobarafter -g 100' do
  not_if 'cat /etc/passwd | grep foobarafter:'
end

# Undeclared, should report an error
execute 'useradd errorafter -U' do
  not_if 'cat /etc/passwd | grep errorafter:'
end

# Create a group (declared so should be ok)
execute 'groupadd -g 2410 devops' do
  not_if 'cat /etc/group | grep devops:'
end

# Create an undeclared group
execute 'groupadd -g 2510 anotherfail' do
  not_if 'cat /etc/group | grep anotherfail:'
end
