peopletools Chef cookbook
=========================
The peopletools cookbook provides resources and recipes to install and configure an Oracle PeopleTools stack.  This is based on the Puppet code and archive files in the Oracle DPK bundle (starting with 8.55.01).

Requirements
------------
- Chef 12.5 or higher
- Ruby 2.0 or higher (preferably from the Chef full-stack installer)
- Network accessible package repositories

Platform Support
----------------
The following platforms have been tested with Test Kitchen:
- CentOS
- Red Hat

Dependencies
------------
This cookbook depends on the following cookbooks.
- `ark`

Usage
-----
#### metadata.rb
Include `peopletools` as a dependency in your cookbook's `metadata.rb`.

```
depends 'peopletools', '~> 2.3.7'
```

Copy the tgz archive files for Oracle Inventory, JDK, PS Home, Tuxedo, WebLogic, etc from the Oracle delivered DPK to a repository such as Artifactory.  Configure a `['peopletools']['archive_repo']` attribute to point to the repository location.  Use the resources to deploy and configure PeopleTools.

Resources
---------
#### Config:

#### `peopletools_appserver_domain`
Resource to configure appserver domain.

##### properties
- `config_settings`: Config settings. Default: {}.
- `domain_name`: Domain name. Name Property.
- `domain_user`: Domain user. Default: 'psadm2'.
- `env_settings`: Environment settings. Default: [].
- `feature_settings`: Feature settings. Default: [].
- `psadmin_path`: Path to psadmin. Default: ::File.join(ps_home, 'appserv/psadmin').
- `port_settings`: Port settings %w(WSL_PORT JSL_PORT JRAD_PORT). Default: [].
- `ps_home`: PS Home. Required.
- `ps_cfg_home`: PS Config Home. Required.
- `sensitive`: Ensure that sensitive resource data is not logged by the chef-client (true | false). Default: false.
- `startup_settings`: Startup settings. Required.
- `template_type`: Template type (small | medium | large | developer). Default: 'small'.

##### actions
- `create` (Default)
- `boot`
- `shutdown`

#### `peopletools_prcs_domain`
Resource to configure prcs domain.

##### properties
- `config_settings`: Config settings. Default: {}.
- `domain_name`: Domain name. Name Property.
- `domain_user`: Domain user. Default: 'psadm2'.
- `env_settings`: Environment settings.
- `feature_settings`: Feature settings. Default: [].
- `psadmin_path`: Path to psadmin. Default: ::File.join(ps_home, 'appserv/psadmin').
- `ps_home`: PS Home. Required.
- `ps_cfg_home`: PS Config Home. Required.
- `sensitive`: Ensure that sensitive resource data is not logged by the chef-client (true | false). Default: false.
- `startup_settings`: Startup settings. Required.
- `template_type`: Template type (unix). Default: 'unix'.

##### actions
- `create` (Default)
- `start`
- `stop`

#### `peopletools_tnsnames`
Resource to configure tnsnames.ora.

##### properties
- `db_host`: Database host. Required.
- `db_name`: Database name. Required.
- `db_port`: Database port. Default: '1521'.
- `db_protocol`: Database protocol (SDP | TCP | TCPS). Default: 'TCP'.
- `db_service_name` Database service name. Default: db_name.
- `group`: tnsnames.ora group. Default: 'oinstall'.
- `mode`: tnsnames.ora mode. Default: '0644'.
- `oracle_client_version`: Oracle Client version. Name Property.
- `owner`: tnsnames.ora owner. Default: 'oracle'.
- `path`: tnsnames.ora path. Default: "/opt/oracle/psft/pt/oracle-client/#{oracle_client_version}/network/admin".
- `server`: Server type (DEDICATED | SHARED). Default: 'DEDICATED'.

##### actions
- `create`

#### `peopletools_webserver_domain`
Resource to configure webserver domain.

##### properties
- `admin_password`: Admin password. Required.
- `admin_userid`: Admin userid. Default: 'system'.
- `appserver_name`: Application server name. Default ''.
- `appserver_connection_password`: Application server domain connection password. Default ''.
- `authentication_token_domain`: Authentication token domain. Default: ''.
- `bea_home`: WebLogic home. Default: '/opt/oracle/psft/pt/bea'.
- `domain_name`: Webserver domain name. Name Property.
- `domain_type`: Domain type(NEW_DOMAIN | EXISTING_DOMAIN). Default: 'NEW_DOMAIN'.
- `domain_user`: Domain user. Default: 'psadm2'.
- `http_port`: HTTP port. Default: 80.
- `https_port`: HTTPS port. Default: 443.
- `igw_userid`: Integration gateway userid. Default: 'administrator'.
- `igw_password`: Integration gateway password. Required.
- `install_action`: Install action (CREATE_NEW_DOMAIN | REDEPLOY_PSAPP | REBUILD_DOMAIN | ADD_SITE | ADD_PSAPP_EXT). Default: 'CREATE_NEW_DOMAIN'.
- `install_type`: Install type (SINGLE_SERVER_INSTALLATION | MULTI_SERVER_INSTALLATION). Default: 'SINGLE_SERVER_INSTALLATION'.
- `jsl_port`: JSL port. Default: 9000.
- `server_type`: Server type (weblogic | websphere). Default: 'weblogic'.
- `setup_path`: PIA setup.sh path. Default: ::File.join(ps_home, 'setup/PsMpPIAInstall/setup.sh').
- `ps_home`: PS Home. Required.
- `ps_cfg_home`: PS Config Home. Required.
- `psserver`: Comma separated list of servers in the format appserver:jslport. Default: ''.
- `reports_dir`: Root directory for report repository. Default: ::File.join(ps_cfg_home, 'PeopleSoft Internet Architecture/psreports').
- `response_file_cookbook`: Cookbook containing response file template to enable overriding in wrapper cookbook. Default: 'peopletools'.
- `response_file_path`: Response file path. Default: '/tmp/webserver-response'.
- `response_file_source`: Response file template source to enable overriding in wrapper cookbook. Default: 'config/webserver_domain/webserver-response.erb'.
- `web_profile_name`: Web profile name. Default: 'PROD'.
- `web_profile_password`: Web profile password. Required.
- `web_profile_userid`: Web profile userid. Default: 'PTWEBSERVER'.
- `website_name`: Website name. Default: 'ps'.

##### actions
- `create`

#### Deployment:

#### `peopletools_inventory`
Resource to deploy Oracle Inventory.

##### properties
- `inventory_location`: Inventory location. Default: '/opt/oracle/psft/db/oraInventory'.
- `inventory_user`: Inventory user. Default: 'oracle'.
- `inventory_group`: Inventory group. Default: 'oinstall'.
- `inventory_minimum_ver`: Inventory minimum version. Default: '2.1.0.6.0'.
- `inventory_saved_with`: Inventory saved with version. Default: '13.2.0.0.0'.

##### actions
- `create`

#### `peopletools_jdk`
Resource to deploy Oracle JDK.

##### properties
- `archive_url`: JDK archive file URL. Required.
- `deploy_location`: Deploy location. Default: "/opt/oracle/psft/pt/jdk#{version}".
- `deploy_user`: Deploy user. Default: 'psadm1'.
- `deploy_group`: Deploy group. Default: 'oinstall'.
- `version`: JDK version. Name Property.

##### actions
- `deploy`

#### `peopletools_oracle_client`
Resource to deploy Oracle Client.

##### properties
- `archive_url`: Oracle Client archive file URL. Required.
- `deploy_location`: Deploy location. Default: "/opt/oracle/psft/pt/oracle-client/#{version}".
- `deploy_user`: Deploy user. Default: 'oracle'.
- `deploy_group`: Deploy group. Default: 'oinstall'.
- `home_name`: Oracle Client inventory home name. Default: 'OraClient12cHome'.
- `inventory_location`: Inventory location. Default: '/opt/oracle/psft/db/oraInventory'.
- `inventory_user`: Inventory user. Default: 'oracle'.
- `inventory_group`: Inventory group. Default: 'oinstall'.
- `tmp_dir`: Temporary directory for extracting archive. Default: "/opt/oracle/psft/pt/oracle-client/#{version}/oc_tmp".
- `version`: Oracle Client version. Name Property.

##### actions
- `deploy`

#### `peopletools_ps_app_home`
Resource to deploy Oracle PS App Home.

##### properties
- `archive_url`: PS App Home archive file URL. Required.
- `db_platform`: Database platform (ORACLE | DB2ODBC | DB2UNIX). Default: 'ORACLE'.
- `deploy_location`: Deploy location. Default: '/opt/oracle/psft/pt/ps_app_home'.
- `deploy_user`: Deploy user. Default: 'psadm3'.
- `deploy_group`: Deploy group. Default: 'appinst'.
- `extract_only`: Extract archive only (true | false). Default: false.
- `version`: PS App Home version. Name Property.

##### actions
- `deploy`

#### `peopletools_ps_home`
Resource to deploy Oracle PS Home.

##### properties
- `archive_url`: PS Home archive file URL. Required.
- `db_platform`: Database platform (ORACLE | DB2ODBC | DB2UNIX). Default: 'ORACLE'.
- `deploy_location`: Deploy location. Default: "/opt/oracle/psft/pt/ps_home#{version}".
- `deploy_user`: Deploy user. Default: 'psadm1'.
- `deploy_group`: Deploy group. Default: 'oinstall'.
- `extract_only`: Extract archive only (true | false). Default: false.
- `unicode_db`: Unicode database (true | false). Default: true.
- `version`: PS Home version. Name Property.

##### actions
- `deploy`

#### `peopletools_tuxedo`
Resource to deploy Oracle Tuxedo.

##### properties
- `archive_url`: Tuxedo archive file URL. Required.
- `deploy_location`: Deploy location. Default: '/opt/oracle/psft/pt/bea/tuxedo'.
- `deploy_user`: Deploy user. Default: 'psadm1'.
- `deploy_group`: Deploy group. Default: 'oinstall'.
- `home_name`: Oracle Client inventory home name. Default: 'OraTuxHome'.
- `inventory_location`: Inventory location. Default: '/opt/oracle/psft/db/oraInventory'.
- `inventory_user`: Inventory user. Default: 'oracle'.
- `inventory_group`: Inventory group. Default: 'oinstall'.
- `sensitive`: Ensure that sensitive resource data is not logged by the chef-client (true | false). Default: false.
- `tlisten_password`: Tuxedo listener password. Required.
- `version`: Tuxedo version. Name Property.

##### actions
- `deploy`

#### `peopletools_weblogic`
Resource to deploy Oracle WebLogic.

##### properties
- `archive_url`: WebLogic archive file URL. Required.
- `deploy_location`: Deploy location. Default: '/opt/oracle/psft/pt/bea'.
- `deploy_user`: Deploy user. Default: 'psadm1'.
- `deploy_group`: Deploy group. Default: 'oinstall'.
- `home_name`: Oracle Client inventory home name. Default: 'OraWLHome'.
- `inventory_location`: Inventory location. Default: '/opt/oracle/psft/db/oraInventory'.
- `inventory_user`: Inventory user. Default: 'oracle'.
- `inventory_group`: Inventory group. Default: 'oinstall'.
- `jdk_location`: JDK location. Default: "/opt/oracle/psft/pt/jdk#{jdk_version}".
- `jdk_version`: JDK version. Required.
- `tmp_dir`: Temporary directory for extracting archive. Default: '/opt/oracle/psft/pt/wl_tmp'.
- `version`: WebLogic version. Name Property.

##### actions
- `deploy`

#### Setup:

#### `peopletools_bashrc`
Resource to configure .bashrc.

##### properties
- `cobol_dir`: COBOL directory. Default: '/opt/microfocus/cobol'.
- `custom_commands`: Custom commands for .bashrc file. Default: [].
- `db2_instance_user`: DB2 instance user. Optional.
- `group`: .bashrc group. Default: 'oinstall'.
- `mode`: .bashrc mode. Default: '0644'.
- `oracle_client_version`: Oracle Client version. Required.
- `oracle_home`: Oracle Home path. Default: "/opt/oracle/psft/pt/oracle-client/#{oracle_client_version}".
- `owner`: .bashrc owner. Name Property.
- `path`: .bashrc path. Default: "/home/#{owner}".
- `ps_app_home`: PS App Home path. Default: '/opt/oracle/psft/pt/ps_app_home'.
- `ps_cfg_home`: PS Config Home path. Default: path.
- `ps_cust_home`: PS Custom Home path. Default: "#{path}/custom".
- `ps_home`: PS Home path. Default: "/opt/oracle/psft/pt/ps_home#{ps_home_version}".
- `ps_home_version`: PS Home version. Required.
- `tns_admin`: TNS admin path. Optional.
- `tuxedo_dir`: Tuxedo directory. Default: "/opt/oracle/psft/pt/bea/tuxedo/tuxedo#{tuxedo_version}".
- `tuxedo_version`: Tuxedo version. Required.

##### actions
- `create`

Examples
--------
#### Application server recipe
```
# users, groups, and system settings
include_recipe "#{cookbook_name}::_common"

# oracle_client
peopletools_oracle_client '12.1.0.2' do
  archive_url "#{node['peopletools']['archive_repo']}/pt-oracleclient-12.1.0.2.tgz"
end

# tnsnames
peopletools_tnsnames '12.1.0.2' do
  db_host 'localhost'
  db_name 'KITCHEN'
end

# ps_home
peopletools_ps_home '8.56.04' do
  archive_url "#{node['peopletools']['archive_repo']}/pt-pshome8.56.04.tgz"
end

# tuxedo
peopletools_tuxedo '12.2.2.0.0' do
  archive_url "#{node['peopletools']['archive_repo']}/pt-tuxedo12.2.2.0.0.tgz"
  sensitive true
  tlisten_password 'tlisten_password'
end

# .bashrc
peopletools_bashrc 'psadm2' do
  oracle_client_version '12.1.0.2'
  ps_home_version '8.56.04'
  tuxedo_version '12.2.2.0.0'
end

# appserver domain
peopletools_appserver_domain 'KIT' do
  config_settings(
    '[Domain Settings]' => ['Allow Dynamic Changes=Y', 'Domain ID=KIT'],
    '[SMTP Settings]' => ['SMTPServer=localhost']
  )
  feature_settings [
    '{PUBSUB}=No', # Pub/Sub Servers
    '{QUICKSRV}=No', # Quick Server
    '{QUERYSRV}=Yes', # Query Servers
    '{JOLT}=Yes', # Jolt
    '{JRAD}=No', # Jolt Relay
    '{WSL}=Yes', # WSL
    '{DBGSRV}=No', # PC Debugger
    '{RENSRV}=No', # Event Notification
    '{MCF}=No', # MCF Servers
    '{PPM}=No', # Perf Collator
    '{ANALYTICSRV}=No', # Analytic Servers
    '{DOMAIN_GW}=No', # Domains Gateway
    '{SERVER_EVENTS}=No' # Push Notifications
  ]
  ps_home '/opt/oracle/psft/pt/ps_home8.56.04'
  ps_cfg_home '/home/psadm2'
  sensitive true
  startup_settings [
    node['peopletools']['db_name'], # Database name
    'ORACLE', # Database type
    'opr_user_id', # OPR user ID
    'opr_user_password', # OPR user password
    'KIT', # Domain ID
    '_____', # Add to path
    'connect_id', # Connect ID
    'connect_password', # Connect password
    '_____', # Server name
    'domain_connection_password', # Domain connection password
    'ENCRYPT' # (NO)ENCRYPT passwords
  ]
end
```

### Process Scheduler recipe
```
# users, groups, and system settings
include_recipe "#{cookbook_name}::_common"

# oracle_client
peopletools_oracle_client '12.1.0.2' do
  archive_url "#{node['peopletools']['archive_repo']}/pt-oracleclient-12.1.0.2.tgz"
end

# tnsnames
peopletools_tnsnames '12.1.0.2' do
  db_host node['peopletools']['db_host']
  db_name node['peopletools']['db_name']
end

# ps_home
peopletools_ps_home '8.56.04' do
  archive_url "#{node['peopletools']['archive_repo']}/pt-pshome8.56.04.tgz"
end

# tuxedo
peopletools_tuxedo '12.2.2.0.0' do
  archive_url "#{node['peopletools']['archive_repo']}/pt-tuxedo12.2.2.0.0.tgz"
  sensitive true
  tlisten_password 'tlisten_password'
end

# .bashrc
peopletools_bashrc 'psadm2' do
  oracle_client_version '12.1.0.2'
  ps_home_version '8.56.04'
  tuxedo_version '12.2.2.0.0'
end

peopletools_prcs_domain 'KIT' do
  config_settings(
    '[Process Scheduler]' => ['Allow Dynamic Changes=Y'],
    '[SMTP Settings]' => ['SMTPServer=localhost']
  )
  feature_settings [
    '{APPENG}=Yes', # App Engine
    '{MSTRSRV}=Yes', # Master Scheduler
    '{PPM}=No', # Perf Collator
    '{DOMAIN_GW}=No', # Domains Gateway
    '{SERVER_EVENTS}=No' # Push Notifications
  ]
  ps_home '/opt/oracle/psft/pt/ps_home8.56.04'
  ps_cfg_home '/home/psadm2'
  sensitive true
  startup_settings [
    node['peopletools']['db_name'], # Database name
    'ORACLE', # Database type
    'PSUNX', # Prcs server
    'opr_user_id', # OPR user ID
    'opr_user_password', # OPR user password
    'connect_id', # Connect ID
    'connect_password', # Connect password
    '_____', # Server name
    '%PS_SERVDIR%/log_output', # Log/output directory
    '%PS_HOME%/bin/sqr/%PS_DB%/bin', # SQRBIN
    '_____', # Add to path
    'domain_connection_password', # Domain connection password
    'ENCRYPT' # (NO)ENCRYPT passwords
  ]
end
```

#### Web server recipe
```
# users, groups, and system settings
include_recipe "#{cookbook_name}::_common"

# ps_home
peopletools_ps_home '8.56.04' do
  archive_url "#{node['peopletools']['archive_repo']}/pt-pshome8.56.04.tgz"
end

# jdk
peopletools_jdk '1.8.0_144' do
  archive_url "#{node['peopletools']['archive_repo']}/pt-jdk1.8.0_144.tgz"
end

# weblogic
peopletools_weblogic '12.2.1' do
  archive_url "#{node['peopletools']['archive_repo']}/pt-weblogic12.2.1.tgz"
  jdk_version '1.8.0_144'
end

# .bashrc
peopletools_bashrc 'psadm2' do
  oracle_client_version '12.1.0.2'
  ps_home_version '8.56.04'
  tuxedo_version '12.2.2.0.0'
end

# webserver domain
peopletools_webserver_domain 'KIT' do
  admin_password 'admin_password'
  appserver_name 'localhost'
  igw_password 'igw_password'
  ps_home '/opt/oracle/psft/pt/ps_home8.56.04'
  ps_cfg_home '/home/psadm2'
  sensitive true
  web_profile_password 'web_profile_password'
end
```

#### Common recipe
```
# groups
node.default['peopletools']['group']['psft_runtime']['name'] = 'psft'
node.default['peopletools']['group']['psft_app_install']['name'] = 'appinst'
node.default['peopletools']['group']['oracle_install']['name'] = 'oinstall'
node.default['peopletools']['group']['oracle_runtime']['name'] = 'dba'

# user defaults
node.default['peopletools']['user']['home_dir'] = '/home'
node.default['peopletools']['user']['shell'] = '/bin/bash'

# users
node.default['peopletools']['user']['psft_install']['name'] = 'psadm1'
node.default['peopletools']['user']['psft_runtime']['name'] = 'psadm2'
node.default['peopletools']['user']['psft_app_install']['name'] = 'psadm3'
node.default['peopletools']['user']['oracle']['name'] = 'oracle'

# limits
node.default['peopletools']['limits']['group']['hard']['nofile'] = 65_536
node.default['peopletools']['limits']['group']['soft']['nofile'] = 65_536
node.default['peopletools']['limits']['group']['hard']['nproc'] = 65_536
node.default['peopletools']['limits']['group']['soft']['nproc'] = 65_536
node.default['peopletools']['limits']['group']['hard']['core'] = 'unlimited'
node.default['peopletools']['limits']['group']['soft']['core'] = 'unlimited'
node.default['peopletools']['limits']['group']['hard']['memlock'] = 500_000
node.default['peopletools']['limits']['group']['soft']['memlock'] = 500_000
node.default['peopletools']['limits']['group']['hard']['stack'] = 102_400
node.default['peopletools']['limits']['group']['soft']['stack'] = 102_400
node.default['peopletools']['limits']['user']['hard']['nofile'] = 131_072
node.default['peopletools']['limits']['user']['soft']['nofile'] = 131_072
node.default['peopletools']['limits']['user']['hard']['nproc'] = 131_072
node.default['peopletools']['limits']['user']['soft']['nproc'] = 131_072
node.default['peopletools']['limits']['user']['hard']['core'] = 'unlimited'
node.default['peopletools']['limits']['user']['soft']['core'] = 'unlimited'
node.default['peopletools']['limits']['user']['hard']['memlock'] = 500_000
node.default['peopletools']['limits']['user']['soft']['memlock'] = 500_000

# sysctl parameters
node.default['sysctl']['params']['kernel']['core_uses_pid'] = 1
node.default['sysctl']['params']['kernel']['msgmnb'] = 65_538
node.default['sysctl']['params']['kernel']['msgmni'] = 1024
node.default['sysctl']['params']['kernel']['msgmax'] = 65_536
node.default['sysctl']['params']['kernel']['shmmax'] = 68_719_476_736
node.default['sysctl']['params']['kernel']['shmall'] = 4_294_967_296
node.default['sysctl']['params']['kernel']['shmmni'] = 4096
node.default['sysctl']['params']['net']['ipv4']['ip_local_port_range'] = '10000 65500'
node.default['sysctl']['params']['net']['ipv4']['tcp_keepalive_time'] = 90
node.default['sysctl']['params']['net']['ipv4']['tcp_timestamps'] = 1
node.default['sysctl']['params']['net']['ipv4']['tcp_window_scaling'] = 1
include_recipe 'sysctl::apply'

# groups
[
  node['peopletools']['group']['psft_runtime']['name'],
  node['peopletools']['group']['psft_app_install']['name'],
  node['peopletools']['group']['oracle_install']['name'],
  node['peopletools']['group']['oracle_runtime']['name']
].each do |g|
  group g do
    append true
    action :create
  end
end

# users
{
  node['peopletools']['user']['psft_install']['name'] => node['peopletools']['group']['oracle_install']['name'],
  node['peopletools']['user']['psft_runtime']['name'] => node['peopletools']['group']['oracle_install']['name'],
  node['peopletools']['user']['psft_app_install']['name'] => node['peopletools']['group']['psft_app_install']['name'],
  node['peopletools']['user']['oracle']['name'] => node['peopletools']['group']['oracle_install']['name']
}.each do |n, g|
  user n do
    gid g
    home ::File.join(node['peopletools']['user']['home_dir'], n)
    shell node['peopletools']['user']['shell']
    supports manage_home: true
  end
end

# psft_runtime group membership
group node['peopletools']['group']['psft_runtime']['name'] do
  append true
  members [
    node['peopletools']['user']['psft_install']['name'],
    node['peopletools']['user']['psft_runtime']['name'],
    node['peopletools']['user']['psft_app_install']['name']
  ]
  action :create
end

# oracle_runtime group membership
group node['peopletools']['group']['oracle_runtime']['name'] do
  append true
  members node['peopletools']['user']['oracle']['name']
  action :create
end

# limits
[
  node['peopletools']['group']['psft_runtime']['name'],
  node['peopletools']['group']['psft_app_install']['name']
].each do |g|
  limits_config g do
    limits_array = []
    node['peopletools']['limits']['group'].each do |t, a|
      a.each do |i, v|
        limits_array.push(domain: g, type: t, item: i, value: v)
      end
    end
    limits limits_array
    only_if { node['peopletools']['limits']['group'].respond_to?('each') }
  end
end

# pt directory
directory '/opt/oracle/psft/pt' do
  owner node['peopletools']['user']['psft_install']['name']
  group node['peopletools']['group']['oracle_install']['name']
  mode '0755'
  recursive true
end

# ps_cust_home directory
directory ::File.join(node['peopletools']['user']['home_dir'], node['peopletools']['user']['psft_runtime']['name'], 'custom') do
  owner node['peopletools']['user']['psft_runtime']['name']
  group node['peopletools']['group']['oracle_install']['name']
  mode '0755'
  recursive true
end
```

Testing
-------
.kitchen.yml is configured to use vagrant with centos-7.2.  Two environment variables must be configured to set the `['peopletools']['archive_repo']` and `['peopletools']['ps_app_home']['archive_repo']` attribute values.  These should be set to the location of the repositories which hold the archive files for PeopleTools and ps_app_home.  They can be different locations if required, and should not contain a trailing forward slash.  E.g.

```
PEOPLETOOLS_ARCHIVE_REPO=http://artifacts.local.org/artifactory/software/oracle/peoplesoft/peopletools/8.56.04
PEOPLETOOLS_PS_APP_HOME_ARCHIVE_REPO=http://artifacts.local.org/artifactory/software/oracle/peoplesoft/finance/9.2.017
```

Contributing
------------
1. Fork the repository on GitHub.
2. Create a named feature branch (like `add_component_x`).
3. Write your change.
4. Write tests for your change (this cookbook currently uses InSpec with Test Kitchen).
5. Run the tests, ensuring they all pass.
6. Submit a Pull Request using GitHub.

License and Authors
-------------------
Author: Richard Lock

Copyright 2016 University of Derby

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
