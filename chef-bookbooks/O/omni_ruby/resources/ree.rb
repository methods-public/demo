#
# Cookbook Name:: omni_ruby
# Resource:: ree
#
# Copyright 2012-2014, Chris Roberts <chrisroberts.code@gmail.com>
# Copyright 2017, SpinDance, Inc.
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
resource_name :omni_ruby_ree
provides :ruby_ree

default_action :install

property :ree_source_url, String, required: false, default: 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/rubyenterpriseedition/ruby-enterprise-1.8.7-2012.02.tar.gz'
property :ree_package_dependencies, Array, required: false, default: node['omni_ruby']['ree_package_dependencies']
property :source_dir, String, required: false, default: '/usr/src'
property :source_install_dir, String, required: false, default: '/usr/local'

action :install do
  extend OmniRubyHelpers
  ruby_zip = ::File.basename(ree_source_url)
  ruby_ver = ruby_zip.sub('.tar.gz', '')

  include_recipe 'build-essential'

  ree_package_dependencies.each do |pkg|
    package pkg
  end

  remote_file "#{source_dir}/#{ruby_zip}" do
    source ree_source_url
    not_if { ::File.exist?("#{source_dir}/#{ruby_zip}") }
  end

  execute 'Extract REE' do
    cwd source_dir
    command "tar xvzf #{ruby_zip}"
    creates "#{source_dir}/#{ruby_ver}"
  end

  ree_patch(ree_source_url, source_dir)

  execute 'Install REE' do
    cwd "#{source_dir}/#{ruby_ver}"
    command "./installer --auto=#{source_install_dir}"
    action :nothing
    subscribes :run, 'execute[Extract REE]'
    notifies :reload, 'ohai[ruby]', :immediately
  end

  ruby_path(source_install_dir)
end

action :uninstall do
  # TODO
end
