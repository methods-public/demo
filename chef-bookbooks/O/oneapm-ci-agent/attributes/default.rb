#
# Cookbook Name:: oneapm-ci-agent
# Attributes:: default
#

# Place your LICENSE Key here, or set it on the role/environment/node
# The oneapm-ci-agent api key to associate your agent's data with your organization.
default['oneapm-ci-agent']['license_key'] = nil

# Don't change these
# The host of the oneapm-ci-agent intake server to send agent data to
default['oneapm-ci-agent']['ci_url'] = 'https://dc-cloud.oneapm.com'

# Add tags as override attributes in your role
default['oneapm-ci-agent']['tags'] = ''

# Repository configuration
architecture_map = {
  'i686' => 'i386',
  'i386' => 'i386',
  'x86' => 'i386'
}
architecture_map.default = 'x86_64'

default['oneapm-ci-agent']['installrepo'] = true
default['oneapm-ci-agent']['aptrepo'] = 'http://apt.oneapm.com/'
default['oneapm-ci-agent']['aptrepo_dist'] = 'stable'
default['oneapm-ci-agent']['yumrepo'] = "http://yum.oneapm.com/#{architecture_map[node['kernel']['machine']]}/"

# Values that differ on Windows
# The location of the config folder (containing conf.d)
# The name of the dd agent service
if node['platform_family'] == 'windows'
  default['oneapm-ci-agent']['config_dir'] = "#{ENV['ProgramData']}/Oneapm-Ci-Agent"
  default['oneapm-ci-agent']['agent_name'] = 'Oneapm-Ci-Agent'
else
  default['oneapm-ci-agent']['config_dir'] = '/etc/oneapm-ci-agent'
  default['oneapm-ci-agent']['agent_name'] = 'oneapm-ci-agent'
end

# DEPRECATED
# Set to true to always install oneapm-ci-agent-base (usually only installed on
# systems with a version of Python lower than 2.6) instead of oneapm-ci-agent
#
# The .gsub is done because some platforms may append characters that aren't valid for a Gem::Version comparison.
begin
  default['oneapm-ci-agent']['install_base'] = Gem::Version.new(node['languages']['python']['version'].gsub(/(\d\.\d\.\d).+/, '\\1')) < Gem::Version.new('2.6.0')
rescue NoMethodError # nodes['languages']['python'] == nil
  Chef::Log.warn 'no version of python found, please install Agent version 5.x or higher.' unless platform_family?('windows')
rescue ArgumentError
  Chef::Log.warn "could not parse python version string: #{node['languages']['python']['version']}"
end

# Agent Version
# Default of `nil` will install latest version. On Windows, this will also upgrade to latest
default['oneapm-ci-agent']['agent_version'] = nil

# Agent package action
# Allow override with `upgrade` to get latest (Linux only)
default['oneapm-ci-agent']['agent_package_action'] = 'install'

# Chef handler version
default['oneapm-ci-agent']['chef_handler_version'] = nil

# Enable the Chef handler to report to oneapm-ci-agent
default['oneapm-ci-agent']['chef_handler_enable'] = true

# Log level. Should be a valid python log level https://docs.python.org/2/library/logging.html#logging-levels
default['oneapm-ci-agent']['log_level'] = 'INFO'

# Default to false to non_local_traffic
default['oneapm-ci-agent']['non_local_traffic'] = false

# The loopback address the Forwarder and Onestatsd will bind.
default['oneapm-ci-agent']['bind_host'] = 'localhost'

# How often you want the agent to collect data, in seconds. Any value between
# 15 and 60 is a reasonable interval.
default['oneapm-ci-agent']['check_freq'] = 15

# Specify agent hostname
default['oneapm-ci-agent']['hostname'] = node.name

# If running on ec2, if true, use the instance-id as the host identifier
# rather than the hostname for chef-handler.
default['oneapm-ci-agent']['use_ec2_instance_id'] = false

# Use mount points instead of volumes to track disk and fs metrics
default['oneapm-ci-agent']['use_mount'] = false

# Change port the agent is listening to
default['oneapm-ci-agent']['agent_port'] = 10010

# Start agent or not
default['oneapm-ci-agent']['agent_start'] = true

# Start a graphite listener on this port
default['oneapm-ci-agent']['graphite'] = false
default['oneapm-ci-agent']['graphite_port'] = 17124

# log-parsing configuration
default['oneapm-ci-agent']['dogstreams'] = []

# custom emitter configuration
default['oneapm-ci-agent']['custom_emitters'] = []

# Logging configuration
default['oneapm-ci-agent']['syslog']['active'] = false
default['oneapm-ci-agent']['syslog']['udp'] = false
default['oneapm-ci-agent']['syslog']['host'] = nil
default['oneapm-ci-agent']['syslog']['port'] = nil

# Web proxy configuration
default['oneapm-ci-agent']['web_proxy']['host'] = nil
default['oneapm-ci-agent']['web_proxy']['port'] = nil
default['oneapm-ci-agent']['web_proxy']['user'] = nil
default['oneapm-ci-agent']['web_proxy']['password'] = nil
default['oneapm-ci-agent']['web_proxy']['skip_ssl_validation'] = nil # accepted values 'yes' or 'no'
default['oneapm-ci-agent']['web_proxy']['proxy_forbid_method_switch'] = nil # accepted values 'yes' or 'no'

# onestatsd
default['oneapm-ci-agent']['onestatsd'] = true
default['oneapm-ci-agent']['onestatsd_port'] = 8251
default['oneapm-ci-agent']['onestatsd_interval'] = 10
default['oneapm-ci-agent']['onestatsd_normalize'] = 'yes'
default['oneapm-ci-agent']['statsd_forward_host'] = nil
default['oneapm-ci-agent']['statsd_forward_port'] = 8251

# For service-specific configuration, use the integration recipes included
# in this cookbook, and apply them to the appropirate node's run list.
