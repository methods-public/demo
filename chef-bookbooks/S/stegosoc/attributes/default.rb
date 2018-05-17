
default['stegosoc']['wazuh-manager']['ip'] = '172.31.57.155' # Private IP Override Wazuh-Manager Server-IP
# default['stegosoc']['wazuh-manager']['ip'] = "ec2-34-196-81-45.compute-1.amazonaws.com" # (Does not work on DNS)Public DNS IP Override Wazuh-Manager Server-IP
# default['stegosoc']['wazuh-manager']['ip'] = '54.236.19.17' # Override Wazuh-Manager Server-IP
default['stegosoc']['wazuh-manager']['port'] = '1515'

default['stegosoc']['coon']['agent_unique_name'] = "#{node['hostname']}".tr("-",'')
default['stegosoc']['coon']['syscheck_frequency'] = '3600'

node.default['apt']['compile_time_update'] = true

#enable start ssm-agent service at boot time
node.default['ssm_agent']['service']['actions'] = %w(enable start)

