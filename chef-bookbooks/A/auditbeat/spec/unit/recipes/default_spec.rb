require 'spec_helper'

describe 'auditbeat::default' do
  shared_examples_for 'auditbeat' do
    context 'all_platforms' do
      it 'run ruby_block delay auditbeat service start' do
        expect(chef_run).to run_ruby_block('delay auditbeat service start')
      end

      it 'enable auditbeat service' do
        expect(chef_run).to enable_service('auditbeat')
      end
    end
  end

  context 'preview' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    it 'include auditbeat::install_package_preview recipe' do
      expect(chef_run).to include_recipe('auditbeat::install_package_preview')
    end

    it 'install auditbeat package' do
      expect(chef_run).to install_package('auditbeat')
    end

    it 'download auditbeat package file' do
      expect(chef_run).to create_remote_file('auditbeat_package_file')
    end
  end

  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.override['auditbeat']['version'] = '6.0.0'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'auditbeat'

    it 'configure /etc/auditbeat/auditbeat.yml' do
      expect(chef_run).to create_file('/etc/auditbeat/auditbeat.yml')
    end

    it 'adds beats yum repository' do
      expect(chef_run).to create_yum_repository('beats')
    end

    it 'include recipe auditbeat::install_package' do
      expect(chef_run).to include_recipe('auditbeat::install_package')
    end

    it 'install auditbeat package' do
      expect(chef_run).to install_package('auditbeat')
    end

    it "has correct default['auditbeat']['config']['auditbeat']['registry_file']" do
      expect(node['auditbeat']['config']['auditbeat']['registry_file']).to eq('/var/lib/auditbeat/registry')
    end

    it "has correct default['auditbeat']['conf_dir']" do
      expect(node['auditbeat']['conf_dir']).to eq('/etc/auditbeat')
    end

    it 'add yum_version_lock auditbeat' do
      expect(chef_run).to update_yum_version_lock('auditbeat')
    end
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
        node.override['lsb']['codename'] = 'trusty'
        node.override['auditbeat']['version'] = '6.0.0'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'auditbeat'

    it 'configure /etc/auditbeat/auditbeat.yml' do
      expect(chef_run).to create_file('/etc/auditbeat/auditbeat.yml')
    end

    it 'adds beats apt repository' do
      expect(chef_run).to add_apt_repository('beats')
    end

    it 'add apt_preference auditbeat' do
      expect(chef_run).to add_apt_preference('auditbeat')
    end

    it 'include recipe auditbeat::install_package' do
      expect(chef_run).to include_recipe('auditbeat::install_package')
    end

    it 'install auditbeat package' do
      expect(chef_run).to install_package('auditbeat')
    end

    it 'install apt-transport-https package' do
      expect(chef_run).to install_package('apt-transport-https')
    end

    it "has correct default['auditbeat']['config']['auditbeat']['registry_file']" do
      expect(node['auditbeat']['config']['auditbeat']['registry_file']).to eq('/var/lib/auditbeat/registry')
    end

    it "has correct default['auditbeat']['conf_dir']" do
      expect(node['auditbeat']['conf_dir']).to eq('/etc/auditbeat')
    end
  end

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2') do |node|
        node.automatic['platform_family'] = 'windows'
        node.automatic['platform_family'] = 'windows'
        node.automatic['kernel']['machine'] = 'x86_64'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'auditbeat'

    it 'configure C:/opt/auditbeat/auditbeat-6.0.0-beta1-windows/auditbeat.yml' do
      expect(chef_run).to create_file('C:/opt/auditbeat/auditbeat-6.0.0-beta1-windows-x86_64/auditbeat.yml')
    end

    it 'include recipe auditbeat::install_windows' do
      expect(chef_run).to include_recipe('auditbeat::install_windows')
    end

    it 'download auditbeat package file' do
      expect(chef_run).to create_remote_file('auditbeat_package_file')
    end

    it 'create auditbeat base dir C:/opt/auditbeat' do
      expect(chef_run).to create_directory('C:/opt/auditbeat')
    end

    it 'unzip auditbeat package file to C:/opt/auditbeat' do
      expect(chef_run).to unzip_windows_zipfile_to('C:/opt/auditbeat')
    end

    it 'run powershell_script to install auditbeat as service' do
      expect(chef_run).to run_powershell_script('install auditbeat as service')
    end

    it "has correct default['auditbeat']['conf_dir']" do
      expect(node['auditbeat']['conf_dir']).to eq('C:/opt/auditbeat/auditbeat-6.0.0-beta1-windows-x86_64')
    end

    it "has correct default['auditbeat']['config']['auditbeat']['registry_file']" do
      expect(node['auditbeat']['config']['auditbeat']['registry_file']).to eq('C:/opt/auditbeat/auditbeat-6.0.0-beta1-windows-x86_64/registry')
    end
  end
end
