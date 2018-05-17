

# Source URL of Wazuh Agent

case node['kernel']['machine']
when 'x86_64'
	default['stegosoc']['wazuh']['url'] = "https://packages.wazuh.com/windows/wazuh-winagent-v2.0.1-1.exe"
        default['stegosoc']['wazuh']['dir'] = "C:\Program Files (x86)\ossec-agent"
when 'i386'
	default['stegosoc']['wazuh']['url'] = "https://packages.wazuh.com/windows/wazuh-winagent-v2.0.1-1.exe"
        default['stegosoc']['wazuh']['dir'] = "C:\Program Files\ossec-agent"
end

#wazuh-manager config

default['stegosoc']['wazuh-manager']['ip'] = '172.31.57.155' # Private IP Override Wazuh-Manager Server-IP
# default['stegosoc']['wazuh-manager']['ip'] = "ec2-34-196-81-45.compute-1.amazonaws.com" # (Does not work on DNS)Public DNS IP Override Wazuh-Manager Server-IP
# default['stegosoc']['wazuh-manager']['ip'] = '54.236.19.17' # Override Wazuh-Manager Server-IP
default['stegosoc']['wazuh-manager']['port'] = '1515'

default['stegosoc']['coon']['agent_unique_name'] = "#{node['hostname']}"
default['stegosoc']['coon']['syscheck_frequency'] = '3600'

