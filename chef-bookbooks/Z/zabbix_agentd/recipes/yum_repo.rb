#
# Cookbook Name:: zabbix_agentd
# Recipe:: yum_repo
#
# The MIT License (MIT)
#
# Copyright (c) 2016 cduong13
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

rpm_platform = node['platform']
rpm_platform_version = node['platform_version'].to_f.to_i.to_s
arch = node['kernel']['machine']

zabbix_version = node['zabbix_agentd']['version']
zabbix_release_rpm = node['zabbix_agentd']['repo_rpm_url'][zabbix_version][rpm_platform][rpm_platform_version][arch]['package']
zabbix_release_url = node['zabbix_agentd']['repo_rpm_url'][zabbix_version][rpm_platform][rpm_platform_version][arch]['url']

# Download the Zabbix repository RPM as a local file
remote_file "#{Chef::Config[:file_cache_path]}/#{zabbix_release_rpm}" do
  source "#{zabbix_release_url}/#{zabbix_release_rpm}"
  mode '0644'
end

# Install the Zabbix repository RPM from the local file
package zabbix_release_rpm.to_s do
  provider Chef::Provider::Package::Rpm
  source "#{Chef::Config[:file_cache_path]}/#{zabbix_release_rpm}"
  action :install
end
