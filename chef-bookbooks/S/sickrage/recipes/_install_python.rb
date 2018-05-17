#
# Cookbook Name:: sickrage
# Recipe:: _install_python
#
# Copyright 2015, Jeremy Miller
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'build-essential'

package_list = ['zlib-devel', 'bzip2-devel', 'openssl-devel', 'ncurses-devel', 'sqlite-devel', 'xz']
package_list.each do |pkg|
  package pkg do
    action :install
  end
end

bash 'install python' do
  user 'root'
  code <<-EOH
  cd /opt
  wget --no-check-certificate https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz
  tar xf /opt/Python-2.7.6.tar.xz
  cd /opt/Python-2.7.6
  ./configure --prefix=/usr/local
  make && make altinstall
  EOH
  not_if { File.exist?('/usr/local/bin/python2.7') }
end
