# frozen_string_literal: true
#
# Cookbook:: geminabox-ng
# Recipe:: server
#
# Install and configure the geminabox server
#
# The MIT License (MIT)
#
# Copyright:: 2017, QubitRenegade
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

username = gib_username
data_dir = gib_data_dir
unicorn_config = unicorn_config_file
geminabox_config = gib_config_file
unicorn = unicorn_path
rack_env = gib_rack_env

# Create datadir
directory 'geminabox data directory' do
  owner username
  path data_dir
  recursive true
  action :create
end

# install requisite gems
node['geminabox-ng']['gems'].each do |gem, include|
  next unless include
  rbenv_gem gem do
    user username
    rbenv_version node['geminabox-ng']['ruby_version']
    action :install
  end
end

# geminabox config
template geminabox_config do
  user username
  group username
  mode '0644'
  action :create
end

# Unicorn config
template unicorn_config do
  source 'unicorn.app.erb'
  user username
  group username
  mode '0644'
  action :create
end

# Start geminabox
poise_service 'geminabox' do
  command "#{unicorn} --config-file #{unicorn_config} #{geminabox_config}"
  user username
  environment RACK_ENV: rack_env
  action :enable
end
