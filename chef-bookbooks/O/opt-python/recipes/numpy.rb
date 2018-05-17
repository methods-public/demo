#
# Cookbook Name:: opt-python
# Recipe:: numpy
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

include_recipe 'opt-python::cython'

package 'git'

git "#{node['opt-python']['download_dir']}/numpy" do
  repository "https://github.com/numpy/numpy.git"
  action :sync
end

bash "install_numpy" do
  user "root"
  cwd "#{node['opt-python']['download_dir']}/numpy"
  code <<-EOH
  python setup.py build
  python setup.py install
  EOH
  environment(
    "LD_LIBRARY_PATH" => node['numpy']['ld_library_path'],
    "PYTHONHOME" => "#{node['opt-python']['install_dir']}/python-#{node['opt-python']['version']}",
    "PATH" => "#{node['opt-python']['install_dir']}/python-#{node['opt-python']['version']}/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
  )
  creates "/opt/python-#{node['opt-python']['version']}/lib/python2.7/site-packages/numpy"
end
