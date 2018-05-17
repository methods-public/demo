#
# Cookbook Name:: r1337-certmanage
# Attribute:: default
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# This attribute determines the data bag used for certificates and keys. Doing things this way allows different environments to have different certificate stores.
default['r1337-certmanage']['cert_bag'] = 'certificates'