#
# Cookbook Name:: nginx-pkg
# Recipe:: default
#
#  The default cookbook installs NGINX from a system package.
#

# install the package
package node['nginx-pkg']['package']['name'] do
  version node['nginx-pkg']['package']['version']
end
