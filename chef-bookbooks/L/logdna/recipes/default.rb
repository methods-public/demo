#
# Cookbook:: chef_logdna
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

if node['logdna']['agent_install']
  ## Installing LogDNA Agent:
  begin
    case node['platform']
    when 'debian', 'ubuntu', 'linuxmint'
      include_recipe 'chef-logdna::install_debian'
    when 'redhat', 'centos', 'amazon'
      include_recipe 'chef-logdna::install_redhat'
    else
      raise 'Unsupported platform: #{node["platform"]}!'
    end
    Chef::Log.info('Successfully installed LogDNA Agent onto #{node["platform"]}!')
  rescue StandardError => e
    Chef::Log.error(e.message)
  end
end

if node['logdna']['agent_configure']
  ## Configuring LogDNA Agent:
  begin
    include_recipe 'chef-logdna::configure'
    Chef::Log.info('Successfully configured LogDNA Agent!')
  rescue StandardError => e
    Chef::Log.error(e.message)
  end
end

if node['logdna']['conf_key'] || node['logdna']['agent_service'] == :stop
  ## Enabling the LogDNA Agent Service
  begin
    case node['platform']
    when 'debian', 'ubuntu', 'linuxmint'
      include_recipe 'chef-logdna::service_debian'
    when 'redhat', 'centos', 'amazon'
      include_recipe 'chef-logdna::service_redhat'
    else
      raise 'Unsupported platform: #{node["platform"]}!'
    end
    Chef::Log.info('Successfully enabled LogDNA Agent!')
  rescue StandardError => e
    Chef::Log.error(e.message)
  end
end
