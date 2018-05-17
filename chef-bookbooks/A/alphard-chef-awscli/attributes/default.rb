#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-awscli
# Attribute:: default
#
# Copyright:: 2017, Hydra Technologies, Inc
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
default['alphard']['awscli']['user'] = 'root'
default['alphard']['awscli']['group'] = 'root'
default['alphard']['awscli']['configuration_directory'] = '/var/lib/aws'
# default['alphard']['awscli']['access_key'] = '<your_access_key]>'
# default['alphard']['awscli']['secret_key'] = '<your_secret_key]>'
default['alphard']['awscli']['version'] = '1.3.22'
default['alphard']['awscli']['configuration_file'] = default['alphard']['awscli']['configuration_directory'] + '/config'
