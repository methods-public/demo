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

default['apache']['windows']['extra']['mpm']['winnt']['threadsperchild']     = 150
default['apache']['windows']['extra']['mpm']['winnt']['maxrequestsperchild'] = 0

if node['apache']['windows']['extras'].include?('multilang-errordoc')
  ApacheWindows::Helper.uniquely_add_array(default['apache']['windows']['default_modules'], %w(alias include negotiation))
end
default['apache']['windows']['extra']['multilang-errordoc']['languagepriority'] = %w(en cs de es fr it ja ko nl pl pt-br ro sv tr)

if node['apache']['windows']['extras'].include?('languages')
  ApacheWindows::Helper.uniquely_add_array(default['apache']['windows']['default_modules'], %w(mime negotiation))
end
default['apache']['windows']['extra']['languages']['languagepriority'] = %w(en ca cs da de el eo es et fr he hr it ja ko ltz nl nn no pl pt pt-BR ru sv tr zh-CN zh-TW)

if node['apache']['windows']['extras'].include?('userdir')
  ApacheWindows::Helper.uniquely_add_array(default['apache']['windows']['default_modules'], 'userdir')
end
default['apache']['windows']['extra']['userdir']['home'] = 'My Documents/My Website'
default['apache']['windows']['extra']['userdir']['allowoverride'] = %w(FileInfo AuthConfig Limit Indexes)
default['apache']['windows']['extra']['userdir']['options'] = %w(MultiViews Indexes SymLinksIfOwnerMatch IncludesNoExec)

if node['apache']['windows']['extras'].include?('info')
  ApacheWindows::Helper.uniquely_add_array(default['apache']['windows']['default_modules'], %w(status info))
end
default['apache']['windows']['extra']['info']['serverstatus']['enabled'] = true
default['apache']['windows']['extra']['info']['serverstatus']['allowfrom'] = ['localhost', '127.0.0.1', node['fqdn'].downcase]
default['apache']['windows']['extra']['info']['serverinfo']['enabled'] = true
default['apache']['windows']['extra']['info']['serverinfo']['allowfrom'] = ['localhost', '127.0.0.1', node['fqdn'].downcase]
default['apache']['windows']['extra']['info']['extendedstatus'] = false

if node['apache']['windows']['extras'].include?('manual')
  ApacheWindows::Helper.uniquely_add_array(default['apache']['windows']['default_modules'], %w(alias setenvif negotiation))
end

default['apache']['windows']['extra']['default']['timeout'] = 300
default['apache']['windows']['extra']['default']['keepalive'] = 'On'
default['apache']['windows']['extra']['default']['maxkeepaliverequests'] = 100
default['apache']['windows']['extra']['default']['keepalivetimeout'] = 5
default['apache']['windows']['extra']['default']['usecanonicalname'] = 'Off'
default['apache']['windows']['extra']['default']['accessfilename'] = '.htaccess'
default['apache']['windows']['extra']['default']['serversignature'] = 'On'
default['apache']['windows']['extra']['default']['hostnamelookups'] = 'Off'
default['apache']['windows']['extra']['default']['servertokens'] = 'OS'

if node['apache']['windows']['extras'].include?('ssl')
  unless node['apache']['windows']['listen_ports'].include?('443')
    default['apache']['windows']['listen_ports'] = node['apache']['windows']['listen_ports'] + ['443']
  end
  ApacheWindows::Helper.uniquely_add_array(default['apache']['windows']['default_modules'], ['ssl'])
end

default['apache']['windows']['extra']['ssl']['passphrase_dialog'] = 'builtin'
default['apache']['windows']['extra']['ssl']['session_cache_timeout'] = 300

default['apache']['windows']['extra']['vhosts']['dir'] = "#{node['apache']['windows']['dir']}/vhosts.d"
