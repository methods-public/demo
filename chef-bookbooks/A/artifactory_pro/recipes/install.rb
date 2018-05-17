#
# Cookbook Name:: artifactory_pro
# Recipe:: install
#
# Copyright (C) 2015 Monkey Little
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

package 'rsync'

remote_file "#{Chef::Config[:file_cache_path]}/artifactory-#{node['artifactory_pro']['install']['version']}.rpm" do
  source node['artifactory_pro']['install']['url']
  not_if 'rpm -ql artifactory'
end

rpm_package 'artifactory' do
  source "#{Chef::Config[:file_cache_path]}/artifactory-#{node['artifactory_pro']['install']['version']}.rpm"
  action :install
  not_if 'rpm -ql artifactory'
end

service 'artifactory' do
  supports start: true, stop: true, restart: true, status: true
  action [:enable, :start]
end