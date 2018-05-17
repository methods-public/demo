#
# Author:: Frederic Nowak (<frederic.nowak@alphard.io>)
# Cookbook:: alphard-chef-s3cmd
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
default['alphard']['s3cmd']['user'] = 'root'
default['alphard']['s3cmd']['group'] = 'root'
default['alphard']['s3cmd']['configuration_directory'] = '/var/lib/s3cmd'
# default['alphard']['s3cmd']['access_key'] = '<your_access_key]>'
# default['alphard']['s3cmd']['secret_key'] = '<your_secret_key]>'
default['alphard']['s3cmd']['version'] = '1.6.1'
default['alphard']['s3cmd']['configuration_file'] = default['alphard']['s3cmd']['configuration_directory'] + '/config'
