#
# Cookbook Name:: r1337-sshconfig
# Recipe:: default
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This recipe will deploy SSH settings based on the ['r1337-sshconfig']['sshpolicy'] attribute
if node['r1337-sshconfig']['sshpolicy'] == 'hardened'
  include_recipe 'r1337-sshconfig::hardenedssh'
else
  # Setting standard as the else allows it to be the default if there is a typo in the attribute override
  include_recipe 'r1337-sshconfig::standardssh'
end
