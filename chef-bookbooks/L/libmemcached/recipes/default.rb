#
# Cookbook Name:: libmemcached
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"

# gcc-c++ is not pard of opscode build-essential cookbook for Centos/RHEL
case node['platform_family']
when "rhel", "fedora", "suse"
  %w{ cloog-ppl cyrus-sasl-devel gcc-c++ }.each do |pkg|
    package pkg
  end
when "debian"
  %w{ libsasl2-dev libcloog-ppl-dev libcloog-ppl0 }.each do |pkg|
    package pkg
  end
end

version = node['libmemcached']['version']
major_version = "#{node['libmemcached']['version'].chars.first}.0"
tarball_name = "libmemcached-#{version}.tar.gz"
tarball_url = "https://launchpad.net/libmemcached/#{major_version}/#{version}/+download/libmemcached-#{version}.tar.gz"


remote_file "/tmp/#{tarball_name}" do
 source "#{tarball_url}"
 mode "0644"
end

execute "tar" do
 user "root"

 cwd "/tmp/"
 command "tar zxf #{tarball_name}"
 creates "/tmp/" + tarball_name.gsub(".tar.gz", "")
 action :run
end


bash "install_libmemcached" do
  user "root"

  cwd "/tmp/" + tarball_name.gsub(".tar.gz", "")
  code <<-EOH
    ./configure
    make install
  EOH
  not_if { FileTest.exists?("/usr/local/lib/libmemcached.so") }
end
