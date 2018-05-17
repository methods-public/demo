
# Cookbook:: desalination
# Spec:: redhat
#
# Copyright:: 2018, Jon Middleton
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

require 'spec_helper'

describe 'desalination::redhat' do
  context 'When all attributes are default, on Centos 7.4.1708' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'stops salt-minion service' do
      expect(chef_run).to stop_service('salt-minion')
    end

    it 'disables salt-minion service' do
      expect(chef_run).to disable_service('salt-minion')
    end

    it 'removes salt-minion package' do
      expect(chef_run).to remove_package('salt-minion')
    end

    it 'removes salt package' do
      expect(chef_run).to remove_package('salt')
    end

    it 'removes salt-repo package' do
      expect(chef_run).to remove_package('salt-repo')
    end

    it 'deletes /etc/salt' do
      expect(chef_run).to delete_directory('/etc/salt')
    end
  end
end
