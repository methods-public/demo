#
# Cookbook Name:: patchman
# Recipe:: rhel
#
# Copyright 2014
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# install yum-crom package
package 'yum-cron' do
  action :install
end

# create /root/yum-cron folder
directory '/root/yum-cron' do
  owner 'root'
  group 'root'
  mode 00644
  action :create
end

# move /etc/cron.daily/0yum.cron to /root/yum-cron/yum.cron check for file and if exists move
execute '0yum.cron move' do
  command 'mv /etc/cron.daily/0yum.cron /root/yum-cron/yum.cron'
  only_if { File.exist?('/etc/cron.daily/0yum.cron') }
end

# add templated /etc/sysconfig/yum-cron file to system
template '/etc/sysconfig/yum-cron' do
  cookbook node['patchman']['template']['yum-cron']
  source 'yum-cron.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(cookbook_name: cookbook_name)
end

# add motd message, if motd exists create as motd.tail
if File.size?('/etc/motd')
  template '/etc/motd.tail' do
    cookbook node['patchman']['template']['motd']
    source 'motd.erb'
    mode 0644
    owner 'root'
    group 'root'
    variables(cookbook_name: cookbook_name)
  end
  log 'Appears you already have a motd setup, adding motd.tail file. Ensure your system can run it.' do
    level :warn
  end
else
  template '/etc/motd' do
    cookbook node['patchman']['template']['motd']
    source 'motd.erb'
    mode 0644
    owner 'root'
    group 'root'
    variables(cookbook_name: cookbook_name)
  end
end

# setup cronjob to run /root/yum-cron/yum.cron
if node['patchman']['environment'] == 'prod' && node['patchman']['prod']['cron']['enable']
  cron 'patchman' do
    minute node['patchman']['prod']['time']['minute']
    hour node['patchman']['prod']['time']['hour']
    weekday node['patchman']['prod']['day']
    command '/root/yum-cron/yum.cron'
  end
elsif node['patchman']['environment'] == 'test' && node['patchman']['test']['cron']['enable']
  cron 'patchman' do
    minute node['patchman']['test']['time']['minute']
    hour node['patchman']['test']['time']['hour']
    weekday node['patchman']['test']['day']
    command '/root/yum-cron/yum.cron'
  end
else
  log 'Unable to setup cron job...ABORTED' do
    level :warn
  end
end
