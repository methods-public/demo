#
# Cookbook Name::	grubby
# Author::        Jeremy MAURO (j.mauro@criteo.com)
#
#

default['grubby']['sysconfig'] = '/etc/sysconfig/kernel'
# Default package configuration:
#   * UPDATEDEFAULT specifies if new-kernel-pkg should make
#     new kernels the default
default['grubby']['config']['UPDATEDEFAULT'] = 'yes'
#   * DEFAULTKERNEL specifies the default kernel package type
default['grubby']['config']['DEFAULTKERNEL'] = 'kernel'
