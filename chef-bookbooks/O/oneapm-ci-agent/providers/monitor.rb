# Creates the proper yaml file in /etc/oneapm-ci-agent/conf.d/

# Defined since Chef 11
use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :add do
  Chef::Log.debug "Adding monitoring for #{new_resource.name}"
  template ::File.join(node['oneapm-ci-agent']['config_dir'], 'conf.d', "#{new_resource.name}.yaml") do
    if node['platform_family'] == 'windows'
      owner 'Administrators'
      rights :full_control, 'Administrators'
      inherits false
    else
      owner 'oneapm-ci-agent'
      mode 00600
    end
    variables(
      :init_config => new_resource.init_config,
      :instances   => new_resource.instances
    )
    cookbook new_resource.cookbook
    notifies :restart, 'service[oneapm-ci-agent]', :delayed if node['oneapm-ci-agent']['agent_start']
  end

  service 'oneapm-ci-agent' do
    service_name node['oneapm-ci-agent']['agent_name']
  end
end

action :remove do
  confd_dir = ::File.join(node['oneapm-ci-agent']['config_dir'], 'conf.d')
  Chef::Log.debug "Removing #{new_resource.name} from #{confd_dir}"
  file ::File.join(confd_dir, "#{new_resource.name}.yaml") do
    action :delete
    notifies :restart, 'service[oneapm-ci-agent]', :delayed if node['oneapm-ci-agent']['agent_start']
  end

  service 'oneapm-ci-agent' do
    service_name node['oneapm-ci-agent']['agent_name']
  end
end
