# encoding: UTF-8
#
# Cookbook Name:: cxs
# Resources:: cxs
# Author:: Vassilis Aretakis (<vassilis@aretakis.eu>)
# Copyright:: Copyright (c) 2017 Vassilis Aretakis
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

resource_name :cxs

default_action :install

action :install do
  unless ::File.exist?('/usr/sbin/cxs')
    unless CXSLicense.valid?
      Chef::Log.fatal ('CXS has no valid license, not installing')
      raise 'CXS has no valid license, not installing'
    end
    remote_file '/tmp/cxs.tgz' do
      source 'https://download.configserver.com/cxsinstaller.tgz'
    end
    directory '/opt/cxs'
    execute 'extract cxs' do
      command '/bin/tar -xzf /tmp/cxs.tgz'
      cwd '/opt/cxs'
    end
    execute 'install cxs' do
      command '/usr/bin/perl /opt/cxs/cxsinstaller.pl'
      cwd '/opt/'
    end
    directory '/opt/cxs' do
      action :delete
      recursive true
    end
  end
end


action :uninstall do
  if ::File.exist?('/usr/sbin/cxs')
    execute 'cxs license clean' do
      command '/usr/sbin/cxs -y'
    end
    execute 'cxs uninstall' do
      command '/etc/cxs/uninstall.sh'
    end
  end
end
