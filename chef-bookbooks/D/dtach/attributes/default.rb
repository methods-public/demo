# Encoding: utf-8
#
# Cookbook Name:: dtach
# Recipe:: default
#
# Copyright 2014, Ross Timson
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

default['dtach']['version'] = '0.8'
default['dtach']['checksum'] = '16614ebddf8ab2811d3dc0e7f329c7de88929ac6a9632d4cb4aef7fe11b8f2a9' # rubocop:disable LineLength
default['dtach']['install_path'] = '/usr/local/bin'
