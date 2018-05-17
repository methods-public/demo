#
# Cookbook Name:: apache2-windows
# Recipe:: default
#
# Copyright 2013, Chef Software, Inc.
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

default['apache']['windows']['version']         = '2.2.25'
default['apache']['windows']['dir']             = "#{ENV['PROGRAMFILES']}/Apache Software Foundation/Apache#{node['apache']['windows']['version'].split('.')[0..1].join('.')}"
default['apache']['windows']['bin_dir']         = "#{node['apache']['windows']['dir']}/bin"
default['apache']['windows']['conf_dir']        = "#{node['apache']['windows']['dir']}/conf.d"
default['apache']['windows']['display_name']    = "Apache HTTP Server #{node['apache']['windows']['version']}"
default['apache']['windows']['package_name']    = "httpd-#{node['apache']['windows']['version']}-win32-x86-openssl-0.9.8y.msi"
default['apache']['windows']['source']          = "http://archive.apache.org/dist/httpd/binaries/win32/#{node['apache']['windows']['package_name']}"
default['apache']['windows']['log_dir']         = 'logs' # relative to ServerRoot
default['apache']['windows']['error_log']       = 'error.log'
default['apache']['windows']['access_log']      = 'access.log'
default['apache']['windows']['user']            = 'daemon'
default['apache']['windows']['group']           = 'daemon'
default['apache']['windows']['conf']            = "#{node['apache']['windows']['dir']}/conf/httpd.conf"
default['apache']['windows']['extras_dir']      = "#{node['apache']['windows']['dir']}/conf/extra"
default['apache']['windows']['binary']          = "#{node['apache']['windows']['bin_dir']}/httpd.exe"
default['apache']['windows']['docroot_dir']     = "#{node['apache']['windows']['dir']}/htdocs"
default['apache']['windows']['cgibin_dir']      = "#{node['apache']['windows']['dir']}/cgi-bin"
default['apache']['windows']['icondir']         = "#{node['apache']['windows']['dir']}/icons"
default['apache']['windows']['cache_dir']       = "#{node['apache']['windows']['dir']}/cache"
default['apache']['windows']['ssl_dir']         = "#{node['apache']['windows']['dir']}/ssl"
default['apache']['windows']['pid_file']        = "#{node['apache']['windows']['log_dir']}/httpd.pid"
default['apache']['windows']['lib_dir']         = "#{node['apache']['windows']['dir']}/modules"
default['apache']['windows']['libexecdir']      = node['apache']['windows']['lib_dir']
default['apache']['windows']['serveradmin']     = "admin@#{node['fqdn']}"
default['apache']['windows']['default_modules'] = %w( actions alias asis auth_basic authn_default authn_file authz_default authz_groupfile authz_host authz_user autoindex cgi dir env include isapi log_config mime negotiation setenvif )

# General settings
default['apache']['windows']['listen_ports']      = %w(80)
default['apache']['windows']['listen_addresses']  = %w(*)

# Extras to enable -- these correspond with the extras files that come out of the box
# Supported 'extras': autoindex, mpm, languages, userdir, info, manual, default, ssl
default['apache']['windows']['extras']            = []
