#
# Cookbook Name:: mod_pagespeed
# Attributes:: default
#
# Copyright 2013, ZOZI
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

default['mod_pagespeed']['package_link'] =
case node['platform_family']
when 'debian'
  if node['kernel']['machine'] =~ /^i[36']86$/
    'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_i386.deb'
  else
    'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb'
  end
when 'rhel', 'fedora'
  if node['kernel']['machine'] =~ /^i[36']86$/
    'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_i386.rpm'
  else
    'https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_x86_64.rpm'
  end
end

default['mod_pagespeed']['enabled?'] = true
default['mod_pagespeed']['vhostconfig'] = true
default['mod_pagespeed']['custom_directives'] = []
