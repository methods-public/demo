# encoding: UTF-8
#
# Cookbook Name:: boxbilling
# Attributes:: default
# Author:: Raul Rodriguez (<raul@onddo.com>)
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014-2015 Onddo Labs, SL.
# License:: Apache License, Version 2.0
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

# Fix for Ubuntu 14
# https://github.com/opscode-cookbooks/php/pull/107
if node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 12.10
  default['php']['ext_conf_dir'] = '/etc/php5/mods-available'
end

default['apt']['compile_time_update'] = true unless node['apt'].nil?

default['boxbilling']['version'] = '4.19.1'
default['boxbilling']['download_url'] =
  'https://github.com/boxbilling/boxbilling/releases/download/%{version}/'\
  'BoxBilling.zip'

default['boxbilling']['required_packages'] = %w( unzip )
default['boxbilling']['php_packages'] =
  case node['platform']
  when 'redhat', 'centos', 'scientific', 'fedora', 'suse', 'amazon', 'oracle'
    %w( php-curl php-mcrypt php-mysql )
  when 'debian', 'ubuntu'
    %w( php5-curl php5-mcrypt php5-mysql )
  else
    Chef::Log.warn("Unknown platform (#{node['platform']}), guessing required "\
      "package names. You may need to set the node['boxbilling']['php']"\
      "['packages'] attribute.")
    %w( php-curl php-mcrypt php-mysql )
  end

default['boxbilling']['dir'] = '/srv/www/boxbilling'
default['boxbilling']['server_name'] = node['fqdn'] || 'boxbilling.local'
default['boxbilling']['server_aliases'] = nil
default['boxbilling']['cron_enabled'] = true
default['boxbilling']['headers'] = {}

default['boxbilling']['ssl'] = true
default['boxbilling']['encrypt_attributes'] = false
default['boxbilling']['web_server'] = 'apache'

default['boxbilling']['admin']['email'] =
  "admin@#{node['boxbilling']['server_name']}"
default['boxbilling']['admin']['pass'] = nil

# Available timezones: http://php.net/manual/en/timezones.php
default['boxbilling']['config']['timezone'] = 'America/New_York'
default['boxbilling']['config']['db_host'] = 'localhost'
default['boxbilling']['config']['db_name'] = 'boxbilling'
default['boxbilling']['config']['db_user'] = 'boxbilling'
default['boxbilling']['config']['db_password'] = nil
default['boxbilling']['config']['url'] =
"http://#{node['boxbilling']['server_name']}/"
default['boxbilling']['config']['license'] = nil
default['boxbilling']['config']['locale'] = 'en_US'
default['boxbilling']['config']['sef_urls'] = false
default['boxbilling']['config']['debug'] = Chef::Config[:log_level] == :debug

default['boxbilling']['api_config']['require_referer_header'] = true
default['boxbilling']['api_config']['allowed_ips'] = []
default['boxbilling']['api_config']['rate_span'] = 60 * 60
default['boxbilling']['api_config']['rate_limit'] = 1000

default['boxbilling']['mysql']['server_root_password'] = nil
default['boxbilling']['mysql']['server_debian_password'] = nil
default['boxbilling']['mysql']['server_repl_password'] = nil
