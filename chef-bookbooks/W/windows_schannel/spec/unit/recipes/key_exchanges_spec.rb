#
# Cookbook Name:: windows_schannel
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'windows_schannel::key_exchanges' do
  context 'When all attributes are default, on an windows platform it' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012r2')
      runner.converge(described_recipe)
    end
    it 'configures the use of the Diffie-Hellman Key Exchange' do
      expect(chef_run).to create_registry_key('keyEx_dh')
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
