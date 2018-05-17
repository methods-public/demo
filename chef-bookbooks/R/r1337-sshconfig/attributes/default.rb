#
# Cookbook Name:: r1337-sshconfig
# Attribute:: default
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This attribute determines which SSH configuration is applied. We default to standard
default['r1337-sshconfig']['sshpolicy'] = 'standard'