#
# Cookbook:: chef-attributes
# Spec:: default
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

require 'spec_helper'
require 'chefspec'

describe 'chef-attributes::default' do
  package_checks = {
    'ubuntu' => ['14.04', '16.04'],
    'centos' => ['7.0']
  }
  package_checks.each do |platform, versions|
    versions.each do |version|
      context "When all attributes are default, on #{platform} #{version}" do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform.to_s, version: version.to_s).converge(described_recipe)
        end

        it 'converges successfully' do
          expect { chef_run }.to_not raise_error
        end
      end
    end
  end
end
