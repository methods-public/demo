#
# Cookbook Name:: omni_ruby
# Resource:: source
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
resource_name :omni_ruby_source
provides :ruby_source

default_action :install

property :source_version, String, required: true, default: '1.9.3-p551'
property :source_package_dependencies, Array, required: false, default: node['omni_ruby']['source_package_dependencies']
property :source_dir, String, required: false, default: '/usr/src'
property :source_install_dir, String, required: false, default: '/usr/local'

action :install do
  extend OmniRubyHelpers
  include_recipe 'build-essential'

  source_package_dependencies.each do |pkg|
    package pkg
  end

  remote_file "#{source_dir}/ruby-#{source_version}.tar.gz" do
    source "http://ftp.ruby-lang.org/pub/ruby/#{source_version[0..2]}/ruby-#{source_version}.tar.gz"
    action :create_if_missing
    not_if { Mixlib::ShellOut.new('ruby --version').run_command.stdout.include?(source_version) }
  end

  execute 'Extract Ruby' do
    cwd source_dir
    command "tar xvzf ruby-#{source_version}.tar.gz"
    creates "#{source_dir}/ruby-#{source_version}"
  end

  source_patch(source_version, source_dir)

  bash 'install_ruby' do
    cwd "#{source_dir}/ruby-#{source_version}"
    code <<-EOH
      autoconf
      ./configure --prefix=#{source_install_dir} --disable-install-doc --enable-shared
      make -j#{node['cpu']['total'] + 1}
      make install
    EOH
    action :nothing
    subscribes :run, 'execute[Extract Ruby]'
    not_if { Mixlib::ShellOut.new('ruby --version').run_command.stdout.include?(source_version) }
    notifies :reload, 'ohai[ruby]', :immediately
    if node['omni_ruby']['source_optimize']
      environment cflags: "-march=native -pipe -fomit-frame-pointer -O#{node['omni_ruby']['source_optimization_level']}"
    end
  end

  rin_ver = Gem::Version.new(source_version.match(/(\d+\.?){2,3}/).to_s)

  if rin_ver < Gem::Version.new('1.9.0') || node['omni_ruby']['source_rubygems_force']
    include_recipe 'omni_ruby::source_rubygems'
  end

  ruby_path(source_install_dir)
end

action :uninstall do
  # TODO
end
