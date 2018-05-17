#
# Cookbook:: iotop
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'iotop::default' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end


    # it 'has python >= 2.7 installed' do
    #   expect(chef_run).to install_package('python').with(version: '2.7.5')
    # end

    let(:kernel_number) do
      chef.run.run_execute('uname -r | sed s/[-]\.*// | tr -d .')
    end
    it 'has linux kernel >= 2.6.20 installed' do
      puts kernel_number
      expect(kernel_number).to be >= 206
    end
  end
end
