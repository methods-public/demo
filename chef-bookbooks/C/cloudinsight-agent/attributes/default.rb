#
# Cookbook Name:: cloudinsight-agent
# Attributes:: default
#

# Place your LICENSE Key here, or set it on the role/environment/node
# The cloudinsight-agent api key to associate your agent's data with your organization.
default['cloudinsight-agent']['license_key'] = nil

# Don't change these
# The host of the cloudinsight-agent intake server to send agent data to
default['cloudinsight-agent']['ci_url'] = 'https://dc-cloud.oneapm.com'

# Add tags as override attributes in your role
default['cloudinsight-agent']['tags'] = ''

# Repository configuration
architecture_map = {
  'i686' => 'i386',
  'i386' => 'i386',
  'x86' => 'i386'
}
architecture_map.default = 'x86_64'

default['cloudinsight-agent']['installrepo'] = true
default['cloudinsight-agent']['aptrepo'] = 'http://apt.oneapm.com/'
default['cloudinsight-agent']['aptrepo_dist'] = 'stable'
default['cloudinsight-agent']['yumrepo'] = "http://yum.oneapm.com/#{architecture_map[node['kernel']['machine']]}/"

# Values that differ on Windows
# The location of the config folder (containing conf.d)
# The name of the dd agent service
if node['platform_family'] == 'windows'
  default['cloudinsight-agent']['config_dir'] = "#{ENV['ProgramData']}/Cloudinsight-Agent"
  default['cloudinsight-agent']['agent_name'] = 'Cloudinsight-Agent'
else
  default['cloudinsight-agent']['config_dir'] = '/etc/cloudinsight-agent'
  default['cloudinsight-agent']['agent_name'] = 'cloudinsight-agent'
end

# DEPRECATED
# Set to true to always install cloudinsight-agent-base (usually only installed on
# systems with a version of Python lower than 2.6) instead of cloudinsight-agent
#
# The .gsub is done because some platforms may append characters that aren't valid for a Gem::Version comparison.
begin
  default['cloudinsight-agent']['install_base'] = Gem::Version.new(node['languages']['python']['version'].gsub(/(\d\.\d\.\d).+/, '\\1')) < Gem::Version.new('2.6.0')
rescue NoMethodError # nodes['languages']['python'] == nil
  Chef::Log.warn 'no version of python found, please install Agent version 5.x or higher.' unless platform_family?('windows')
rescue ArgumentError
  Chef::Log.warn "could not parse python version string: #{node['languages']['python']['version']}"
end

# Agent Version
# Default of `nil` will install latest version. On Windows, this will also upgrade to latest
default['cloudinsight-agent']['agent_version'] = nil

# Agent package action
# Allow override with `upgrade` to get latest (Linux only)
default['cloudinsight-agent']['agent_package_action'] = 'install'

# Chef handler version
default['cloudinsight-agent']['chef_handler_version'] = nil

# Enable the Chef handler to report to cloudinsight-agent
default['cloudinsight-agent']['chef_handler_enable'] = true

# Log level. Should be a valid python log level https://docs.python.org/2/library/logging.html#logging-levels
default['cloudinsight-agent']['log_level'] = 'INFO'

# Default to false to non_local_traffic
default['cloudinsight-agent']['non_local_traffic'] = false

# The loopback address the Forwarder and Onestatsd will bind.
default['cloudinsight-agent']['bind_host'] = 'localhost'

# How often you want the agent to collect data, in seconds. Any value between
# 15 and 60 is a reasonable interval.
default['cloudinsight-agent']['check_freq'] = 15

# Specify agent hostname
default['cloudinsight-agent']['hostname'] = node.name

# If running on ec2, if true, use the instance-id as the host identifier
# rather than the hostname for chef-handler.
default['cloudinsight-agent']['use_ec2_instance_id'] = false

# Use mount points instead of volumes to track disk and fs metrics
default['cloudinsight-agent']['use_mount'] = false

# Change port the agent is listening to
default['cloudinsight-agent']['agent_port'] = 10010

# Start agent or not
default['cloudinsight-agent']['agent_start'] = true

# Start a graphite listener on this port
default['cloudinsight-agent']['graphite'] = false
default['cloudinsight-agent']['graphite_port'] = 17124

# log-parsing configuration
default['cloudinsight-agent']['dogstreams'] = []

# custom emitter configuration
default['cloudinsight-agent']['custom_emitters'] = []

# Logging configuration
default['cloudinsight-agent']['syslog']['active'] = false
default['cloudinsight-agent']['syslog']['udp'] = false
default['cloudinsight-agent']['syslog']['host'] = nil
default['cloudinsight-agent']['syslog']['port'] = nil

# Web proxy configuration
default['cloudinsight-agent']['web_proxy']['host'] = nil
default['cloudinsight-agent']['web_proxy']['port'] = nil
default['cloudinsight-agent']['web_proxy']['user'] = nil
default['cloudinsight-agent']['web_proxy']['password'] = nil
default['cloudinsight-agent']['web_proxy']['skip_ssl_validation'] = nil # accepted values 'yes' or 'no'
default['cloudinsight-agent']['web_proxy']['proxy_forbid_method_switch'] = nil # accepted values 'yes' or 'no'

# sdk, onestastd
default['cloudinsight-agent']['sdk'] = false
default['cloudinsight-agent']['onestatsd_port'] = 8251
default['cloudinsight-agent']['onestatsd_interval'] = 10
default['cloudinsight-agent']['onestatsd_normalize'] = 'yes'
default['cloudinsight-agent']['statsd_forward_host'] = nil
default['cloudinsight-agent']['statsd_forward_port'] = 8251

# For service-specific configuration, use the integration recipes included
# in this cookbook, and apply them to the appropirate node's run list.
