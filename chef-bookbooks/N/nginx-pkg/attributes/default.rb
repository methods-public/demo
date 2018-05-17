#
# Cookbook Name:: nginx-pkg
# Attributes:: default
#

# The name of the NGINX system package to be installed.
default['nginx-pkg']['package']['name'] = 'nginx'

# The version of the NGINX system package to be installed. This defaults to the
#  most current version of the package as determined by repository priority &
#  settings.
default['nginx-pkg']['package']['version'] = ''
