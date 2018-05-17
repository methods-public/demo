#
# Cookbook Name:: zabbix_agentd
# Recipe:: default
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

case node['platform']
when 'centos', 'redhat'
  include_recipe 'zabbix_agentd::yum_repo'
end

package 'zabbix-agent'

directory node['zabbix_agentd']['log_dir'] do
  owner 'zabbix'
  group 'zabbix'
  recursive true
end

template "#{node['zabbix_agentd']['etc_dir']}/zabbix_agentd.conf" do
  source 'zabbix_agentd.conf.erb'
  notifies :restart, 'service[zabbix-agent]'
end

service 'zabbix-agent' do
  supports restart: true, status: true, reload: true
  action [:enable, :start]
end
