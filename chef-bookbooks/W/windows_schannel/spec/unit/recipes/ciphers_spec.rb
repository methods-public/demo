#
# Cookbook Name:: windows_schannel
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'windows_schannel::ciphers' do
  context 'When all attributes are default, on an windows platform it' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '2012r2')
      runner.converge(described_recipe)
    end
    it 'configures the cipher NULL' do
      expect(chef_run).to create_registry_key('cipher_null')
    end
    it 'configures the cipher DES' do
      expect(chef_run).to create_registry_key('cipher_des')
    end
    it 'configures the cipher RC2' do
      expect(chef_run).to create_registry_key('RC2 40/128')
      expect(chef_run).to create_registry_key('RC2 56/128')
      expect(chef_run).to create_registry_key('RC2 128/128')
    end
    it 'configures the cipher RC4' do
      expect(chef_run).to create_registry_key('RC4 40/128')
      expect(chef_run).to create_registry_key('RC4 56/128')
      expect(chef_run).to create_registry_key('RC4 64/128')
      expect(chef_run).to create_registry_key('RC4 128/128')
    end
    it 'configures the cipher 3DES' do
      expect(chef_run).to create_registry_key('cipher_3des')
    end
    it 'configures the cipher AES' do
      expect(chef_run).to create_registry_key('AES 128/128')
      expect(chef_run).to create_registry_key('AES 256/256')
    end
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
