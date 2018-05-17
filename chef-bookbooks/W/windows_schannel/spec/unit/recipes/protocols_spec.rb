#
# Cookbook Name:: windows_schannel
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'windows_schannel::protocols' do
  context 'When all attributes are default, on an windows platform it' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012r2')
      runner.converge(described_recipe)
    end
    it 'configures the protocol tls_v1.0' do
      expect(chef_run).to create_registry_key('tls_v1.0')
    end
    it 'configures the protocol tls_v1.1' do
      expect(chef_run).to create_registry_key('tls_v1.1')
    end
    it 'configures the protocol tls_v1.2' do
      expect(chef_run).to create_registry_key('tls_v1.2')
    end
    it 'configures the protocol ssl_v2.0' do
      expect(chef_run).to create_registry_key('ssl_v2.0')
    end
    it 'configures the protocol ssl_v3.0' do
      expect(chef_run).to create_registry_key('ssl_v3.0')
    end
    it 'configures the protocol pct_v1.0' do
      expect(chef_run).to create_registry_key('pct_v1.0')
    end
    it 'shouldn\'t by default reboot a computer' do
      expect(chef_run.reboot('computer')).to do_nothing
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
  context 'When the reboot attribute is true, on an windows platform it' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012r2') do |node|
        node.normal['windows_schannel']['allow_reboot'] = true
      end
      runner.converge(described_recipe)
    end

    let(:protocol_change) { chef_run.registry_key('pct_v1.0') }
    it 'should reboot the system' do
      expect(protocol_change).to notify('reboot[computer]').to(:request_reboot).delayed
    end
  end
end
