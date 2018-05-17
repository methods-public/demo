#
# Cookbook Name:: nscp
# Attribute:: default
# Author:: Azat Khadiev <anuriq@gmail.com>
#
# Copyright (C) 2016, Parallels IP Holdings GmbH.
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

default['nscp']['config']['allowed_hosts'] = []
default['nscp']['config']['cache_allowed_hosts'] = true
default['nscp']['config']['timeout'] = 60
default['nscp']['config']['allow_arguments'] = true
default['nscp']['config']['use_ssl'] = false
default['nscp']['config']['log_level'] = 'error'
default['nscp']['config']['default_buffer_length'] = '1m'
default['nscp']['config']['crash_submit'] = false
default['nscp']['config']['crash_archive'] = true
default['nscp']['config']['crash_restart'] = true
default['nscp']['config']['scripts_wrappings'] = {
  'vbs' => 'cscript.exe //T:60 //NoLogo scripts\lib\wrapper.vbs %SCRIPT% %ARGS%',
  'ps1' => 'cmd /c echo %SCRIPT% %ARGS%; exit($lastexitcode) | powershell.exe -command -',
  'bat' => '%SCRIPT% %ARGS%',
  'cmd' => '%SCRIPT% %ARGS%'
}

default['nscp']['template_cookbook'] = 'nscp'
default['nscp']['template_name'] = 'nsclient.ini.erb'
default['nscp']['template_scripts_name'] = 'nsclient_scripts.ini.erb'
default['nscp']['service_name'] = 'nscp'

default['nscp']['checks'] = {}
