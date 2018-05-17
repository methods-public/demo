# encoding: utf-8
#
# Cookbook Name:: docker-integration-test
# Recipe:: default
#
# Author:: Doc Walker (<4-20ma@wvfans.net>)
#
# Copyright 2016, Doc Walker
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

#---------------------------------------------- file[/tmp/quick_brown_fox.txt]
file '/tmp/quick_brown_fox.txt' do |f|
  owner 'root'
  group 'root'
  mode  '0600'
end # file
