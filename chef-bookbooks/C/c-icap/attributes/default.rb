#
# Cookbook Name:: c-icap
# Attributes:: default
# Author:: Rostyslav Fridman (<rostyslav.fridman@gmail.com>)
#
# Copyright 2014, Rostyslav Fridman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['c_icap']['user'] = "c-icap"
default['c_icap']['group'] = "c-icap"
default['c_icap']['install_method'] = "source"

# Used for source installation
#default['c_icap']['url'] = "http://sourceforge.net/projects/c-icap/files/c-icap/0.3.x"
default['c_icap']['url'] = "http://skylink.dl.sourceforge.net/project/c-icap/c-icap/0.3.x"
default['c_icap']['version'] = "0.3.3"
default['c_icap']['checksum'] = "8c209a76eed0a407e1a1d498b1c82371f12aeb2b9d9169a522cb6b374c999a14"
default['c_icap']['prefix_dir'] = "/"
default['c_icap']['exec_prefix_dir'] = "/usr"
default['c_icap']['config_dir'] = "/etc/c-icap"
default['c_icap']['doc_dir'] = "/usr/share"
default['c_icap']['include_dir'] = "/usr/include"
default['c_icap']['configure_options'] = %W{
--prefix=#{c_icap['prefix_dir']}
--exec-prefix=#{c_icap['exec_prefix_dir']}
--datarootdir=#{c_icap['doc_dir']}
--sysconfdir=#{c_icap['config_dir']}
--includedir=#{c_icap['include_dir']}
}

#default['c_icap_modules']['url'] = "http://sourceforge.net/projects/c-icap/files/c-icap-modules/0.3.x/"
default['c_icap_modules']['url'] = "http://skylink.dl.sourceforge.net/project/c-icap/c-icap-modules/0.3.x"
default['c_icap_modules']['version'] = "0.3.2"
default['c_icap_modules']['checksum'] = "e3472662687cf9fa37a496df31436924326e315920056a404f023ec5e852e239"
default['c_icap_modules']['include_dir'] = "/usr/include/c_icap"
default['c_icap_modules']['configure_options'] = %W{
--prefix=#{c_icap['prefix_dir']}
--exec-prefix=#{c_icap['exec_prefix_dir']}
--datarootdir=#{c_icap['doc_dir']}
--sysconfdir=#{c_icap['config_dir']}
--includedir=#{c_icap_modules['include_dir']}
}
