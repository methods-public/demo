#
# Cookbook Name:: dcos-grid
# Recipe:: docker-engine
#
# Copyright 2016, whitestar
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

# https://dcos.io/docs/1.8/administration/installing/custom/system-requirements/

# for deprecated attributes
[
  'apt_repo',
  'yum_repo',
].each {|pkey|
  node['dcos-grid']['docker'][pkey].each {|key, value|
    node.override['docker-grid'][pkey][key] = value unless value.nil?
  }
}

node['dcos-grid']['docker-engine'].each {|key, value|
  next if key == 'setup'
  node.override['docker-grid']['engine'][key] = value unless value.nil?
}

include_recipe 'docker-grid::engine'
