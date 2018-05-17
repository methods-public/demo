#
# Cookbook Name:: yum-dell
# Attributes:: default
#
# Copyright 2010, Eric G. Wolfe
# Copyright 2010, Tippr Inc.
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

# Check for Dell hardware
if node['dmi'] && node['dmi']['system'] &&
   node['dmi']['system']['manufacturer'] &&
   node['dmi']['system']['manufacturer'] =~ /Dell/i &&
   node['platform_version'].to_f >= 5
  default['yum']['dell']['enabled'] = true
else
  default['yum']['dell']['enabled'] = false
end

# Install srvadmin-all meta-package by default
if node['yum']['dell']['enabled']
  default['yum']['dell']['packages'] = %w[ srvadmin-all ]
else
  default['yum']['dell']['packages'] = []
end
