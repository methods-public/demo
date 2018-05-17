#
# Cookbook Name:: dcos-grid
# Recipe:: universe-build-env
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

# https://github.com/mesosphere/universe

case node['platform_family']
when 'rhel'
  [
    'git',
    'epel-release',
    # from EPEL
    'python34-setuptools',
    'jq',
  ].each {|pkg|
    resources(package: pkg) rescue package pkg do
      action :install
    end
  }

  easy_install_package 'jsonschema' do
    easy_install_binary '/usr/bin/easy_install-3.4'
  end
when 'debian'
  [
    'git',
    'python3-pip',
    'jq',
  ].each {|pkg|
    resources(package: pkg) rescue package pkg do
      action :install
    end
  }

  bash 'pip3_install_jsonschema' do
    code <<-EOH
      pip3 install jsonschema
    EOH
    not_if 'pip3 list --format=columns | grep jsonschema'
  end
end

if node['dcos-grid']['docker-engine']['setup']
  include_recipe 'dcos-grid::docker-engine'
end
