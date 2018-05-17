#
# Cookbook Name:: c-icap
# Attributes:: url_check
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

default['c_icap']['url_check']['early_responses'] = nil

default['c_icap']['url_check']['lookup_table']['enabled'] = true
default['c_icap']['url_check']['lookup_table']['databases'] = [
  {
    :name => "denyurls",
    :type => "full_url",
    :path => "hash:/tmp/url-list.txt"
  }
]

default['c_icap']['url_check']['squidguard']['enabled'] = false
default['c_icap']['url_check']['squidguard']['databases'] = [
  {
    :name => "example",
    :path => "/tmp/example"
  }
]

default['c_icap']['url_check']['profile']['enabled'] = true
default['c_icap']['url_check']['profiles'] = [
  {
    :name => "default",
    :action => "block",
    :database => "denyurls"
  }
]

default['c_icap']['url_check']['profile_access']['enabled'] = false
default['c_icap']['url_check']['profile_access']['acls'] = [
  {
    :name => "ExampleACL",
    :ldap_group => "ExampleUsers"
  }
]
default['c_icap']['url_check']['profile_access']['list'] = [
  {
    :name => "ExampleProfile",
    :acl_name => "ExampleACL"
  }
]
