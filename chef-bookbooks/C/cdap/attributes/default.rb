#
# Cookbook Name:: cdap
# Attribute:: default
#
# Copyright © 2013-2017 Cask Data, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Install Java and Hadoop clients by default
default['cdap']['skip_prerequisites'] = false

# User to run hadoop fs commands as
default['cdap']['fs_superuser'] = 'hdfs'

# User information for "cdap" user (otherwise delegates to packages)
default['cdap']['create_cdap_user'] = false
default['cdap']['cdap_user']['username'] = 'cdap'
default['cdap']['cdap_user']['group'] = 'cdap'
default['cdap']['cdap_user']['uid'] = '11011'
default['cdap']['cdap_user']['gid'] = '11011'
