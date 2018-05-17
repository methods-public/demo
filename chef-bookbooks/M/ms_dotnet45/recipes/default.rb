#
# Author:: Timothy Smith (<tsmith@chef.io>)
# Cookbook Name:: ms_dotnet45
# Recipe:: default
#
# Copyright 2012, Webtrends, Inc.
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

if platform?('windows')
  if node['platform_version'].to_i >= 6
    windows_package 'Microsoft .NET Framework 4.5' do # ~FC009
      source node['ms_dotnet45']['http_url']
      installer_type :custom
      options '/quiet /norestart'
      timeout node['ms_dotnet45']['timeout']
      action :install
      success_codes [0, 3010]
      not_if { File.exist?('C:/Windows/Microsoft.NET/Framework/v4.0.30319/Microsoft.Activities.Build.dll') }
    end
  else
    Chef::Log.warn('The .NET 4.5 Chef recipe only supports Windows Vista, 7, 2008, and 2008 R2.')
  end
else
  Chef::Log.warn('Microsoft .NET Framework 4.5 can only be installed on the Windows platform.')
end
