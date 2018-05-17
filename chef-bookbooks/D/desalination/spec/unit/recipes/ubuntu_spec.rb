
# Cookbook:: desalination
# Spec:: ubuntu
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

describe 'desalination::ubuntu' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
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

    it 'purges salt-minion package' do
      expect(chef_run).to purge_package('salt-minion')
    end

    it 'purges salt-common package' do
      expect(chef_run).to purge_package('salt-common')
    end

    it 'deletes /etc/apt/sources.list.d/saltstack.list' do
      expect(chef_run).to delete_file('/etc/apt/sources.list.d/saltstack.list')
    end

    it 'removes SALTSTACK-GPG-KEY.pub apt-key'

    it 'deletes /etc/salt' do
      expect(chef_run).to delete_directory('/etc/salt')
    end
  end
end
