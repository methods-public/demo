#
# Cookbook:: chef-attributes
# Recipe:: default
#
# Copyright (C) 2018,  Rodel Manalo Talampas
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

knife_attribute 'knife_attribute_install' do
  action :install
end

node['chef']['level']['attributes'].each do |level, envts|
  envts.each do |envt, attribs|
    attribs.each do |attrib, value|
      knife_attribute "set_#{level}_#{envt}_#{attrib}_#{value}" do
        level level
        level_name envt
        attribute attrib
        value value
        config node['chef']['configuration']
        action :set
      end
    end
  end
end
