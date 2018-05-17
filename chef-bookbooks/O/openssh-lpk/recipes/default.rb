#
# Author:: John Bellone (<jbellone@bloomberg.net>)
# Cookbook Name:: openssh-lpk
# Recipe:: default
#
# Copyright (C) 2014 Bloomberg Finance L.P.
#
include_recipe 'chef-sugar::default'

if rhel?
  package 'openssh-ldap'
end

if ubuntu_before_trusty?
  Chef::Application.fatal! 'openssh-lpk recipe is not supported before Ubuntu 14.04'
end

node.default['openssh']['server']['authorized_keys_command'] = '/usr/libexec/openssh/ssh-ldap-wrapper'
node.default['openssh']['server']['authorized_keys_command_run_as'] = 'nobody'
node.default['openssh']['server']['use_l_p_k'] = 'yes'
node.default['openssh']['server']['lpk_ldap_conf'] = '/etc/ldap.conf'
include_recipe 'openssh::default'
