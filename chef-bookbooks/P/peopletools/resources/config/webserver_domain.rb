#
# Cookbook Name:: peopletools
# Resource:: webserver_domain
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

resource_name :peopletools_webserver_domain
default_action :create
property :admin_password, String, required: true
property :admin_userid, String, default: 'system'
property :appserver_name, String, default: ''
property :appserver_connection_password, String, default: ''
property :authentication_token_domain, String, default: ''
property :bea_home, String, default: '/opt/oracle/psft/pt/bea'
property :domain_name, String, name_property: true
property :domain_type, equal_to: %w[NEW_DOMAIN EXISTING_DOMAIN], default: 'NEW_DOMAIN'
property :domain_user, String, default: 'psadm2'
property :http_port, Integer, default: 80
property :https_port, Integer, default: 443
property :igw_userid, String, default: 'administrator'
property :igw_password, String, required: true
property :install_action, equal_to: %w[CREATE_NEW_DOMAIN REDEPLOY_PSAPP REBUILD_DOMAIN ADD_SITE ADD_PSAPP_EXT], default: 'CREATE_NEW_DOMAIN'
property :install_type, equal_to: %w[SINGLE_SERVER_INSTALLATION MULTI_SERVER_INSTALLATION], default: 'SINGLE_SERVER_INSTALLATION'
property :jsl_port, Integer, default: 9000
property :server_type, %w[weblogic websphere], default: 'weblogic'
property :setup_path, String, default: lazy { ::File.join(ps_home, 'setup/PsMpPIAInstall/setup.sh') }
property :ps_home, String, required: true
property :ps_cfg_home, String, required: true
property :psserver, String, default: ''
property :reports_dir, String, default: lazy { ::File.join(ps_cfg_home, 'PeopleSoft Internet Architecture/psreports') }
property :response_file_cookbook, String, default: 'peopletools'
property :response_file_path, String, default: '/tmp/webserver-response'
property :response_file_source, String, default: 'config/webserver_domain/webserver-response.erb'
property :web_profile_name, String, default: 'PROD'
property :web_profile_password, String, required: true
property :web_profile_userid, String, default: 'PTWEBSERVER'
property :website_name, String, default: 'ps'

action :create do # rubocop:disable Metrics/BlockLength
  # response file
  template response_file_path do # rubocop:disable Metrics/BlockLength
    cookbook response_file_cookbook
    mode '0600'
    owner domain_user
    sensitive new_resource.sensitive
    source response_file_source
    variables(
      admin_userid: admin_userid,
      admin_password: admin_password,
      appserver_name: appserver_name,
      appserver_connection_password: appserver_connection_password,
      authentication_token_domain: authentication_token_domain,
      bea_home: bea_home,
      domain_name: domain_name,
      domain_type: domain_type,
      http_port: http_port,
      https_port: https_port,
      igw_userid: igw_userid,
      igw_password: igw_password,
      install_action: install_action,
      install_type: install_type,
      jsl_port: jsl_port,
      ps_cfg_home: ps_cfg_home,
      psserver: psserver,
      reports_dir: reports_dir,
      server_type: server_type,
      web_profile_name: web_profile_name,
      web_profile_password: web_profile_password,
      web_profile_userid: web_profile_userid,
      website_name: website_name
    )
    action :create
    not_if { ::File.exist?(::File.join(ps_cfg_home, 'webserv', domain_name)) }
  end # rubocop:enable Metrics/BlockLength

  # $ps_cfg_home/webserv directory
  directory "#{ps_cfg_home}/webserv" do
    owner domain_user
    group 'root'
    mode '0755'
    action :create
    recursive true
  end

  # create webserver domain
  execute 'webserver_domain_create' do
    command "su - #{domain_user} -c \"#{setup_path} -i silent -DRES_FILE_PATH=#{response_file_path}\""
    sensitive new_resource.sensitive
    only_if { ::File.file?(setup_path) }
    not_if { ::File.exist?(::File.join(ps_cfg_home, 'webserv', domain_name)) }
    notifies :run, "ruby_block[chmod_R_#{::File.join(ps_cfg_home, 'webserv', domain_name)}]", :immediately
    notifies :delete, "template[#{response_file_path}]", :immediately
  end

  # weblogic domain directory permissions
  ruby_block "chmod_R_#{::File.join(ps_cfg_home, 'webserv', domain_name)}" do
    block do
      FileUtils.chmod_R 0_755, ::File.join(ps_cfg_home, 'webserv', domain_name)
    end
    only_if { ::File.exist?(::File.join(ps_cfg_home, 'webserv', domain_name)) }
    action :nothing
  end
end # rubocop:enable Metrics/BlockLength
