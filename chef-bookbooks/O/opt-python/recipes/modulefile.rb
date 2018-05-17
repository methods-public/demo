#
# Cookbook Name:: opt-python
# Recipe:: modulefile
# Author:: Koji Tanaka (<kj.tanaka@gmail.com>)
#
# Copyright 2014, FutureGrid Project, Indiana University
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

directory "#{node['opt-python']['modulefiles_dir']}/python" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "#{node['opt-python']['modulefiles_dir']}/python/#{node['opt-python']['version']}" do
  source "modulefile.erb"
  variables(
    :python_install_dir => node['opt-python']['install_dir']
  )
end

template "#{node['opt-python']['modulefiles_dir']}/python/.version" do
  source "dot.version.erb"
  variables(
    :python_default_version => node['opt-python']['default_version']
  )
end
