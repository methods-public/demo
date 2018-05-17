#
# Cookbook Name:: linux-basic
# Recipe:: security
#
# Copyright 2015, http://DennyZhang.com
#
# All rights reserved - Do Not Redistribute
#

# #################### openssh ########################
# # depends "openssh"
# # https://supermarket.chef.io/cookbooks/openssh

# node.default[:openssh][:server][:password_authentication] = "yes"
# node.default[:openssh][:server][:port] = "22"
# include_recipe "openssh"
# #####################################################

#################### selinux ########################
# https://supermarket.chef.io/cookbooks/selinux
# depends "selinux"
# Doesn't support Ubuntu OS: https://github.com/skottler/selinux/issues/22
# node.default["selinux"]["state"] = "disabled"
# selinux_state "SELinux #{node['selinux']['state'].capitalize}" do
#   action node['selinux']['state'].downcase.to_sym
# end
#####################################################
