#
# Author:: Lance Powell (<lanceraymondpowell@gmail.com>)
# Cookbook Name:: filezilla
# Recipe:: default
#
# Copyright (c) 2015 Lance Powell, All Rights Reserved.
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

# Installs the client
# Add _server.rb to install the server

case node['platform_family']
  when 'windows'

  	filezilla = remote_file node['filezilla']['client']['exe'] do
  	  source node['filezilla']['client']['url']
  	  path File.join('C:\\',node['filezilla']['client']['exe'])
  	  action :create
  	end

     windows_package "FileZilla Install" do
		source File.join('C:\\',node['filezilla']['client']['exe'])
		installer_type :custom
		options "/S /user=all"
		action :install
	  end

# Remove the downloaded exe
    file File.join('C:\\',node['filezilla']['client']['exe']) do
      action :delete
      only_if { filezilla.updated_by_last_action? }
    end

  when 'rhel'
  if node['platform_version'] < '7'
    yum_repository 'epel' do
      description 'Extra Packages for Enterprise Linux'
      mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
      gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
      action :create
    end

    else
      yum_repository 'epel' do
        description 'Extra Packages for Enterprise Linux'
        mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=$basearch'
        gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'
        action :create
      end
    end

    package 'gnutls' do
      action :install
    end

    package 'filezilla' do
      action :install
    end
else # ubuntu
  package 'filezilla' do
    action :install
  end

end
