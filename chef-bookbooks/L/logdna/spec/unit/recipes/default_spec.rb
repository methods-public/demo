require 'spec_helper'

describe 'chef-logdna::default' do
  platforms = [
    { platform: 'ubuntu', version: '14.04', name: 'Trusty' },
    { platform: 'ubuntu', version: '16.04', name: 'Xenial' },
    { platform: 'centos', version: '6.8', name: 'CentOS 6' },
    { platform: 'centos', version: '7.4.1708', name: 'CentOS 7' },
  ]
  platforms.each do |platform|
    platform_name = platform[:name]
    context 'When all attributes are default, ' + platform_name + ': ' do
      before do
        Fauxhai.mock(platform: platform[:platform], version: platform[:version])
      end
      let(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: platform[:platform], version: platform[:version])
        runner.node.set['logdna']['conf_key'] = '0123456789abcdef0123456789'
        runner.converge(described_recipe)
      end
      it 'installed LogDNA Agent!' do
        if platform[:platform] == 'centos'
          expect(chef_run).to install_yum_package('logdna-agent')
        else
          expect(chef_run).to install_apt_package('logdna-agent')
        end
      end
      it 'enabled LogDNA Agent service!' do
        expect(chef_run).to enable_service('logdna-agent')
      end
      it 'started LogDNA Agent service!' do
        expect(chef_run).to start_service('logdna-agent')
      end
    end
  end
end
