# encoding: UTF-8
#
# Cookbook Name:: cxs
# Attributes:: default
# Author:: Vassilis Aretakis (<vassilis@aretakis.eu>)
# Copyright:: Copyright (c) 2017 Vassilis Aretakis
# License:: Apache License, Version 2.0
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

default['cxs']['config']['mail'] = 'root'
default['cxs']['config']['options'] = 'mLScehnwROfGZxdMDuW'
default['cxs']['config']['filemax'] = '0'
default['cxs']['config']['voptions'] = 'mfuhexT'
default['cxs']['config']['qoptions'] = 'MvB'
default['cxs']['config']['quarantine'] = '/home/quarantine'
default['cxs']['config']['ignore'] = '/etc/cxs/cxs.ignore'
default['cxs']['config']['xtra'] = '/etc/cxs/cxs.xtra'
default['cxs']['config']['clamsock'] = '/var/clamd'
