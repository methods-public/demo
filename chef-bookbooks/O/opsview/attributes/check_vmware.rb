#
# Cookbook Name:: opsview
# Attributes:: check_vmware
#
# Copyright 2015, Biola University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE_2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['opsview']['check_vmware']['plugin_url'] = "http://git.op5.org/gitweb?p=system-addons/plugins/op5/check_vmware_api.git;a=blob_plain;f=check_vmware_api.pl;hb=47695211eb994057fb50dd0575462c83cd2555b3"
default['opsview']['check_vmware']['plugin_checksum'] = "408c05dd879ab8bf923c6c3480c7c9a1aff83075b646115cde171c485467935c"