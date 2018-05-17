# encoding: UTF-8
#
# Cookbook Name:: openstack-dashboard
# Attributes:: default
#
# Copyright 2012, AT&T, Inc.
# Copyright 2013-2014, IBM, Corp.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Set to some text value if you want templated config files
# to contain a custom banner at the top of the written file
default['openstack']['dashboard']['custom_template_banner'] = '
# This file is automatically generated by Chef
# Any changes will be overwritten
'
# ****************** OpenStack Dashboard Endpoints ******************************

# The OpenStack Dashboard non-SSL endpoint
default['openstack']['bind_service']['dashboard_http']['host'] = '0.0.0.0'
default['openstack']['bind_service']['dashboard_http']['port'] = '80'

# The OpenStack Dashboard SSL endpoint
default['openstack']['bind_service']['dashboard_https']['host'] = '0.0.0.0'
default['openstack']['bind_service']['dashboard_https']['port'] = '443'

# ********************************************************************************

default['openstack']['dashboard']['debug'] = false

# Don't cache html pages.
# NOTE: This setting requires apache 2.4 or greater is used
default['openstack']['dashboard']['cache_html'] = false

# The Keystone role used by default for users logging into the dashboard
default['openstack']['dashboard']['keystone_default_role'] = '_member_'

# This is the name of the Chef role that will install the Keystone Service API
default['openstack']['dashboard']['keystone_service_chef_role'] = 'keystone'

default['openstack']['dashboard']['server_hostname'] = nil
default['openstack']['dashboard']['server_aliases'] = []
default['openstack']['dashboard']['use_ssl'] = true
# When using a remote certificate and key, the names of the actual installed certificate
# and key in the file system are determined by the following two attributes.
# If you want the name of the installed files to match the name of the files from the URL,
# they need to be manually set below, if not the conventional horizon.* names will be used.
default['openstack']['dashboard']['ssl']['cert'] = 'horizon.pem'
default['openstack']['dashboard']['ssl']['key'] = 'horizon.key'
# Optional Chain cert
default['openstack']['dashboard']['ssl']['chain'] = nil
# Which versions of the SSL/TLS protocol will be accepted in new connections.
default['openstack']['dashboard']['ssl']['protocol'] = 'All -SSLv2 -SSLv3'
# Which ciphers to use with the SSL/TLS protocol.
# Example: 'RSA:HIGH:MEDIUM:!LOW:!kEDH:!aNULL:!ADH:!eNULL:!EXP:!SSLv2:!SEED:!CAMELLIA:!PSK!RC4:!RC4-MD5:!RC4-SHA'
default['openstack']['dashboard']['ssl']['ciphers'] = nil
# Use the 'certs' databag for managing certs to disable it to use something
# external
default['openstack']['dashboard']['ssl']['use_data_bag'] = true

# List of hosts/domains the dashboard can serve. This should be changed, a '*'
# allows everything
default['openstack']['dashboard']['allowed_hosts'] = ['*']

default['openstack']['dashboard']['swift']['enabled'] = 'False'

default['openstack']['dashboard']['theme'] = 'default'

default['openstack']['dashboard']['apache']['sites-path'] = "#{node['apache']['dir']}/openstack-dashboard.conf"

# Allow TRACE method
#
# Set to "extended" to also reflect the request body (only for testing and
# diagnostic purposes).
#
# Set to one of:  On | Off | extended
default['openstack']['dashboard']['traceenable'] = node['apache']['traceenable']

default['openstack']['dashboard']['secret_key_content'] = nil

default['openstack']['dashboard']['ssl_no_verify'] = 'True'
default['openstack']['dashboard']['ssl_cacert'] = nil

default['openstack']['dashboard']['webroot'] = '/'

# Dashboard specific database packages
# Put common ones here and platform specific ones below.
default['openstack']['dashboard']['db_python_packages'] = {
  mysql: [],
  sqlite: [],
}

# The hash algorithm to use for authentication tokens. This must match the hash
# algorithm that the identity (Keystone) server and the auth_token middleware
# are using. Allowed values are the algorithms supported by Python's hashlib
# library.
default['openstack']['dashboard']['hash_algorithm'] = 'md5'

case node['platform_family']
when 'rhel'
  default['openstack']['dashboard']['key_group'] = 'root'
  default['openstack']['dashboard']['horizon_user'] = 'apache'
  default['openstack']['dashboard']['horizon_group'] = 'apache'
  default['openstack']['dashboard']['secret_key_path'] = '/usr/share/openstack-dashboard/openstack_dashboard/local/.secret_key_store'
  default['openstack']['dashboard']['ssl']['cert_dir'] = '/etc/pki/tls/certs/'
  default['openstack']['dashboard']['ssl']['key_dir'] = '/etc/pki/tls/private/'
  default['openstack']['dashboard']['local_settings_path'] = '/etc/openstack-dashboard/local_settings'
  default['openstack']['dashboard']['django_path'] = '/usr/share/openstack-dashboard'
  default['openstack']['dashboard']['static_path'] = '/usr/share/openstack-dashboard/static'
  default['openstack']['dashboard']['policy_files_path'] = '/etc/openstack-dashboard'
  default['openstack']['dashboard']['login_url'] = "#{node['openstack']['dashboard']['webroot']}auth/login/"
  default['openstack']['dashboard']['logout_url'] = "#{node['openstack']['dashboard']['webroot']}auth/logout/"
  default['openstack']['dashboard']['login_redirect_url'] = node['openstack']['dashboard']['webroot']
  default['openstack']['dashboard']['platform'] = {
    'horizon_packages' => ['openstack-dashboard'],
    'memcache_python_packages' => ['python-memcached'],
    'package_overrides' => '',
  }
  default['openstack']['dashboard']['apache']['sites-path'] = "#{node['apache']['dir']}/sites-available/openstack-dashboard.conf"
when 'debian'
  default['openstack']['dashboard']['key_group'] = 'ssl-cert'
  default['openstack']['dashboard']['horizon_user'] = 'horizon'
  default['openstack']['dashboard']['horizon_group'] = 'horizon'
  default['openstack']['dashboard']['secret_key_path'] = '/var/lib/openstack-dashboard/secret_key'
  default['openstack']['dashboard']['ssl']['cert_dir'] = '/etc/ssl/certs/'
  default['openstack']['dashboard']['ssl']['key_dir'] = '/etc/ssl/private/'
  default['openstack']['dashboard']['local_settings_path'] = '/etc/openstack-dashboard/local_settings.py'
  default['openstack']['dashboard']['django_path'] = '/usr/share/openstack-dashboard'
  default['openstack']['dashboard']['static_path'] = '/var/lib/openstack-dashboard/static'
  default['openstack']['dashboard']['policy_files_path'] = '/usr/share/openstack-dashboard/openstack_dashboard/conf'
  default['openstack']['dashboard']['login_url'] = nil
  default['openstack']['dashboard']['logout_url'] = nil
  default['openstack']['dashboard']['login_redirect_url'] = nil
  default['openstack']['dashboard']['platform'] = {
    'memcache_python_packages' => ['python-memcache'],
    'package_overrides' => '',
  }
  default['openstack']['dashboard']['platform']['horizon_packages'] = ['node-less', 'openstack-dashboard']
  default['openstack']['dashboard']['apache']['sites-path'] = "#{node['apache']['dir']}/sites-available/openstack-dashboard.conf"
else
  default['openstack']['dashboard']['key_group'] = 'root'
end

default['openstack']['dashboard']['dash_path'] = "#{node['openstack']['dashboard']['django_path']}/openstack_dashboard"
default['openstack']['dashboard']['stylesheet_path'] = '/usr/share/openstack-dashboard/openstack_dashboard/templates/_stylesheets.html'
default['openstack']['dashboard']['wsgi_path'] = node['openstack']['dashboard']['dash_path'] + '/wsgi/django.wsgi'
default['openstack']['dashboard']['wsgi_socket_prefix'] = nil
default['openstack']['dashboard']['session_backend'] = 'memcached'

default['openstack']['dashboard']['ssl_offload'] = true
default['openstack']['dashboard']['plugins'] = nil

default['openstack']['dashboard']['file_upload_temp_dir'] = nil

default['openstack']['dashboard']['error_log'] = 'openstack-dashboard-error.log'
default['openstack']['dashboard']['access_log'] = 'openstack-dashboard-access.log'

default['openstack']['dashboard']['help_url'] = 'http://docs.openstack.org'

default['openstack']['dashboard']['csrf_cookie_secure'] = true
default['openstack']['dashboard']['session_cookie_secure'] = true

default['openstack']['dashboard']['keystone_multidomain_support'] = false
default['openstack']['dashboard']['keystone_default_domain'] = 'default'
default['openstack']['dashboard']['api']['auth']['version'] = node['openstack']['api']['auth']['version']

case node['openstack']['dashboard']['api']['auth']['version']
when 'v2.0'
  default['openstack']['dashboard']['identity_api_version'] = 2.0
when 'v3.0'
  default['openstack']['dashboard']['identity_api_version'] = 3
end

default['openstack']['dashboard']['volume_api_version'] = 2
default['openstack']['dashboard']['console_type'] = 'AUTO'

default['openstack']['dashboard']['keystone_backend']['name'] = 'native'
default['openstack']['dashboard']['keystone_backend']['can_edit_user'] = true
default['openstack']['dashboard']['keystone_backend']['can_edit_group'] = true
default['openstack']['dashboard']['keystone_backend']['can_edit_project'] = true
default['openstack']['dashboard']['keystone_backend']['can_edit_domain'] = true
default['openstack']['dashboard']['keystone_backend']['can_edit_role'] = true

default['openstack']['dashboard']['log_level']['horizon'] = 'INFO'
default['openstack']['dashboard']['log_level']['horizon_log'] = 'INFO'
default['openstack']['dashboard']['log_level']['openstack_dashboard'] = 'INFO'
default['openstack']['dashboard']['log_level']['novaclient'] = 'INFO'
default['openstack']['dashboard']['log_level']['cinderclient'] = 'INFO'
default['openstack']['dashboard']['log_level']['keystoneclient'] = 'INFO'
default['openstack']['dashboard']['log_level']['glanceclient'] = 'INFO'
default['openstack']['dashboard']['log_level']['neutronclient'] = 'INFO'
default['openstack']['dashboard']['log_level']['heatclient'] = 'INFO'
default['openstack']['dashboard']['log_level']['ceilometerclient'] = 'INFO'
default['openstack']['dashboard']['log_level']['troveclient'] = 'INFO'
default['openstack']['dashboard']['log_level']['swiftclient'] = 'INFO'
default['openstack']['dashboard']['log_level']['openstack_auth'] = 'INFO'
default['openstack']['dashboard']['log_level']['nose.plugins.manager'] = 'INFO'
default['openstack']['dashboard']['log_level']['django'] = 'INFO'

default['openstack']['dashboard']['heat_stack']['eanable_user_pass'] = true

default['openstack']['dashboard']['password_autocomplete'] = 'off'
default['openstack']['dashboard']['simple_ip_management'] = false
default['openstack']['dashboard']['neutron']['enable_quotas'] = true
default['openstack']['dashboard']['neutron']['enable_lb'] = false
default['openstack']['dashboard']['neutron']['enable_vpn'] = false
default['openstack']['dashboard']['neutron']['enable_fwaas'] = false
# Allow for misc sections to be added to the local_settings template
# For example: {
#                'CUSTOM_CONFIG_A' => {
#                  'variable1': 'value1',
#                  'variable2': 'value2'
#                }
#                'CUSTOM_CONFIG_B' => {
#                  'variable1': 'value1',
#                  'variable2': 'value2'
#                }
#              }
# will generate:
#  CUSTOM_CONFIG_A = {
#    'varable1': 'value1',
#    'varable2': 'value2',
#  }
#  CUSTOM_CONFIG_A = {
#    'varable1': 'value1',
#    'varable2': 'value2',
#  }
default['openstack']['dashboard']['misc_local_settings'] = nil
# version of python neutron-lbaas-dashboard package to install
default['openstack']['dashboard']['lbaas']['version'] = '3.0.1'