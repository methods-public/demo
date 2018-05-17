#
# Cookbook Name:: opsview
# Attributes:: check_mongodb
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

default['opsview']['check_mongodb']['plugin_url'] = "https://raw.githubusercontent.com/mzupan/nagios-plugin-mongodb/9e277ecea8c69affa38baf3d245c62cbb0b5aa46/check_mongodb.py"
default['opsview']['check_mongodb']['plugin_checksum'] = "d7c7ecb5ae835c56d1293118fb742abd36bac19b9414f94af131b739fc92b8b5"