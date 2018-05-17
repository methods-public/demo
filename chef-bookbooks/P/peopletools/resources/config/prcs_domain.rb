#
# Cookbook Name:: peopletools
# Resource:: prcs_domain
#
# Copyright 2016 University of Derby
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

resource_name :peopletools_prcs_domain
default_action :create
property :config_settings, Hash, default: {}
property :domain_name, String, name_property: true
property :domain_user, String, default: 'psadm2'
property :env_settings, Array
property :feature_settings, Array, default: []
property :psadmin_path, String, default: lazy { ::File.join(ps_home, 'appserv/psadmin') }
property :ps_home, String, required: true
property :ps_cfg_home, String, required: true
property :startup_settings, Array, required: true
property :template_type, equal_to: %w[unix], default: 'unix'

action :create do
  # expand config_settings hash
  config_settings_expanded = []
  if config_settings.respond_to?(:key)
    config_settings.each do |section, settings|
      if settings.respond_to?(:each)
        config_settings_expanded.push(settings.map { |setting| "#{section}/#{setting}" })
      end
    end
  end

  # avoid error if env_settings is not set
  env_settings_command = ''
  if property_is_set?(:env_settings)
    env_settings_command = " -env '#{env_settings.join('#')}'"
  end

  # create prcs domain
  execute 'prcs_domain_create' do
    command "su - #{domain_user} -c \"#{psadmin_path} -p create -d #{domain_name} -t #{template_type} -ps '#{startup_settings.join(',')}'#{env_settings_command}\""
    sensitive new_resource.sensitive
    only_if { ::File.file?(psadmin_path) }
    not_if { ::File.exist?(::File.join(ps_cfg_home, 'appserv/prcs', domain_name)) }
    notifies :run, 'execute[prcs_domain_configure]', :immediately
  end

  # configure prcs domain
  execute 'prcs_domain_configure' do
    command "su - #{domain_user} -c \"#{psadmin_path} -p configure -d #{domain_name} -cfg '#{config_settings_expanded.join('#')}' -u '#{feature_settings.join('%')}'\""
    sensitive new_resource.sensitive
    only_if { ::File.file?(psadmin_path) }
    action :nothing
  end
end

action :start do
  # start prcs domain
  execute 'prcs_domain_start' do
    command "su - #{domain_user} -c \"#{psadmin_path} -p start -d #{domain_name}\""
    only_if { ::File.file?(psadmin_path) && ::File.exist?(::File.join(ps_cfg_home, 'appserv/prcs', domain_name)) }
  end
end

action :stop do
  # stop prcs domain
  execute 'prcs_domain_stop' do
    command "su - #{domain_user} -c \"#{psadmin_path} -p stop -d #{domain_name}\""
    only_if { ::File.file?(psadmin_path) && ::File.exist?(::File.join(ps_cfg_home, 'appserv/prcs', domain_name)) }
  end
end
