#
# Cookbook Name:: centos-preupg
# Recipe:: default
#
# Copyright (C) 2014 North County Tech Center, LLC
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Since the supports attribute in metadata.rb is only informational, we need
# to double-check here.
if node['platform'] != 'centos' then
  raise "Only CentOS can be upgraded"
else
  if node['platform_version'].to_f < 6.6 then
    raise "Upgrade to CentOS 6.6 first!"
  else
    if node['platform_version'].to_f >= 7.0 then
      raise "Already upgraded to CentOS 7"
    else
      yum_repository "upgradetool" do
        description 'CentOS-$releasever - Upgrade Tool'
        baseurl 'http://dev.centos.org/centos/$releasever/upg/$basearch/'
        gpgcheck true
        gpgkey 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6'
        enabled true
        repositoryid 'upg'
        action :create
      end

      %w{ preupgrade-assistant preupgrade-assistant-contents redhat-upgrade-tool }.each do |pkg|
        package pkg do
          action :install
          ignore_failure true
        end
      end

      bash "Clean up some known preliminary stuff" do
        code "semodule -r sandbox"
        only_if "semodule -l | grep sandbox"
      end

      # Very time consuming, we don't want this to run on every chef run, only the first time
      bash "Run Preupgrade Tool" do
        code "/usr/bin/yes | /usr/bin/preupg"
        not_if { File.exists?("/root/preupgrade") }
      end

    end
  end
end

