#
# Cookbook:: chef-collectd
# Recipe:: install
#

include_recipe 'yum-epel' if platform_family?('rhel')

package 'collectd'
