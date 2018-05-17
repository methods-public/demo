#
# Cookbook Name:: peopletools
# Resource:: appserver_domain
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

resource_name :peopletools_appserver_domain
default_action :create
property :config_settings, Hash, default: {}
property :domain_name, String, name_property: true
property :domain_user, String, default: 'psadm2'
property :env_settings, Array, default: []
property :feature_settings, Array, default: []
property :psadmin_path, String, default: lazy { ::File.join(ps_home, 'appserv/psadmin') }
property :port_settings, Array, default: []
property :ps_home, String, required: true
property :ps_cfg_home, String, required: true
property :startup_settings, Array, required: true
property :template_type, equal_to: %w[small medium large developer], default: 'small'

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

  # create appserver domain
  execute 'appserver_domain_create' do
    command "su - #{domain_user} -c \"#{psadmin_path} -c create -d #{domain_name} -t #{template_type} -s '#{startup_settings.join('%')}' -env '#{env_settings.join('#')}' -p '#{port_settings.join('%')}'\""
    sensitive new_resource.sensitive
    only_if { ::File.file?(psadmin_path) }
    not_if { ::File.exist?(::File.join(ps_cfg_home, 'appserv', domain_name)) }
    notifies :run, 'execute[appserver_domain_configure]', :immediately
  end

  # configure appserver domain
  execute 'appserver_domain_configure' do
    command "su - #{domain_user} -c \"#{psadmin_path} -c configure -d #{domain_name} -cfg '#{config_settings_expanded.join('#')}' -u '#{feature_settings.join('%')}'\""
    sensitive new_resource.sensitive
    only_if { ::File.file?(psadmin_path) }
    action :nothing
  end
end

action :boot do
  # boot appserver domain
  execute 'appserver_domain_boot' do
    command "su - #{domain_user} -c \"#{psadmin_path} -c boot -d #{domain_name}\""
    only_if { ::File.file?(psadmin_path) && ::File.exist?(::File.join(ps_cfg_home, 'appserv', domain_name)) }
  end
end

action :shutdown do
  # shutdown appserver domain
  execute 'appserver_domain_shutdown' do
    command "su - #{domain_user} -c \"#{psadmin_path} -c shutdown -d #{domain_name}\""
    only_if { ::File.file?(psadmin_path) && ::File.exist?(::File.join(ps_cfg_home, 'appserv', domain_name)) }
  end
end
