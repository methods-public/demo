#
# Cookbook Name:: diskanalyser
# Recipe:: default
#
# Copyright 2017, LiveLink Technology
#
# All rights reserved - Do Not Redistribute
#
#
apt_update 'diskanalyser' if node['platform_family'] == 'debian'

package 'smartmontools'

cookbook_file '/usr/local/sbin/grab_smartctl.sh' do
  source 'grab_smartctl.sh'
  mode '0755'
end

ohai_plugin 'diskanalyser'
