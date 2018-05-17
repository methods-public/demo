#
# Author:: Yosuke Inoue (<inoue@fieldweb.co.jp>)
# Cookbook Name:: suhosin
# Attribute:: default
#
# Copyright 2015, FIELD Co., Ltd.
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

default['suhosin']['source'] = 'https://download.suhosin.org/suhosin-0.9.37.1.tar.gz'
default['suhosin']['version'] = '0.9.37.1'
default['suhosin']['checksum'] = '322ba104a17196bae63d39404da103fd011b09fde0f02484dc44366511c586ba'