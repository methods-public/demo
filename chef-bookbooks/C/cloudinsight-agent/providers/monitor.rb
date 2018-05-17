# Creates the proper yaml file in /etc/cloudinsight-agent/conf.d/

# Defined since Chef 11
use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :add do
  Chef::Log.debug "Adding monitoring for #{new_resource.name}"
  template ::File.join(node['cloudinsight-agent']['config_dir'], 'conf.d', "#{new_resource.name}.yaml") do
    if node['platform_family'] == 'windows'
      owner 'Administrators'
      rights :full_control, 'Administrators'
      inherits false
    else
      owner 'cloudinsight-agent'
      mode 00600
    end
    variables(
      :init_config => new_resource.init_config,
      :instances   => new_resource.instances
    )
    cookbook new_resource.cookbook
    notifies :restart, 'service[cloudinsight-agent]', :delayed if node['cloudinsight-agent']['agent_start']
  end

  service 'cloudinsight-agent' do
    service_name node['cloudinsight-agent']['agent_name']
  end
end

action :remove do
  confd_dir = ::File.join(node['cloudinsight-agent']['config_dir'], 'conf.d')
  Chef::Log.debug "Removing #{new_resource.name} from #{confd_dir}"
  file ::File.join(confd_dir, "#{new_resource.name}.yaml") do
    action :delete
    notifies :restart, 'service[cloudinsight-agent]', :delayed if node['cloudinsight-agent']['agent_start']
  end

  service 'cloudinsight-agent' do
    service_name node['cloudinsight-agent']['agent_name']
  end
end
