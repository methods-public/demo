nagios-grid Cookbook
====================

This cookbook provides some recipes for Nagios setup.

## Contents

- [Requirements](#requirements)
- [Attributes](#attributes)
- [Usage](#usage)
	- [nagios-grid::default](#nagios-griddefault)
	- [nagios-grid::nagios-base](#nagios-gridnagios-base)
	- [nagios-grid::nagios-nrpe-server](#nagios-gridnagios-nrpe-server)
- [License and Authors](#license-and-authors)
	- [Plugins](#plugins)

## Requirements

None.

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['nagios']['base_cfg_dir']`|String|base conf. directory.|`'base'`|
|`['nagios']['site_cfg_dir']`|String|site conf. directory.|`'site'`|
|`['nagios']['autostart']`|Boolean||`true`|
|`['nagios']['autoreload']`|Boolean||`true`|
|`['nagios']['with_pnp4nagios']`|Boolean||`false`|
|`['nagios']['check_external_commands']`|String|check_external_commands property in nagios.cfg|`'0'`|
|`['nagios']['command_file']`|String|command_file property in nagios.cfg|see default.rb|
|`['nagios']['use_regexp_matching']`|String|use_regexp_matching property in nagios.cfg|`'0'`|
|`['nagios']['cgi']['authorized_for_system_information']`|String|CGI authorization property.|`'nagiosadmin'`|
|`['nagios']['cgi']['authorized_for_configuration_information']`|String|CGI authorization property.|`'nagiosadmin'`|
|`['nagios']['cgi']['authorized_for_system_commands']`|String|CGI authorization property.|`'nagiosadmin'`|
|`['nagios']['cgi']['authorized_for_all_services']`|String|CGI authorization property.|`'nagiosadmin'`|
|`['nagios']['cgi']['authorized_for_all_hosts']`|String|CGI authorization property.|`'nagiosadmin'`|
|`['nagios']['cgi']['authorized_for_all_service_commands']`|String|CGI authorization property.|`'nagiosadmin'`|
|`['nagios']['cgi']['authorized_for_all_host_commands']`|String|CGI authorization property.|`'nagiosadmin'`|
|`['nagios']['cgi']['result_limit']`|String|result set limitation.|`'100'`|
|`['nagios']['web']['Require']`|Array|Apache >= 2.3|`['all granted',]`|
|`['nagios']['web']['Order']`|String|Apache < 2.3|`'Allow,Deny'`|
|`['nagios']['web']['Deny']`|Array|Apache < 2.3|`[]`|
|`['nagios']['web']['Allow']`|Array|Apache < 2.3|`['From All',]`|
|`['nagios']['web']['AuthType']`|String|'none' or 'Basic' or 'Kerberos'|`'Basic'`|
|`['nagios']['web']['mod_auth_basic']['AuthUserFile']`|String||see default.rb|
|`['nagios']['web']['mod_auth_kerb']['KrbAuthRealms']`|String||`'LOCALDOMAIN'`|
|`['nagios']['web']['mod_auth_kerb']['KrbServiceName']`|String||`'HTTP'`|
|`['nagios']['web']['mod_auth_kerb']['Krb5Keytab']`|String||`'/etc/krb5.keytab'`|
|`['nagios']['web']['mod_auth_kerb']['KrbMethodNegotiate']`|String||`'on'`|
|`['nagios']['web']['mod_auth_kerb']['KrbMethodK5Passwd']`|String||`'off'`|
|`['nagios']['objects']['default_contact_groups']`|String||`'admins'`|
|`['nagios']['objects']['check_ldap']['base']`|String||`'dc=example,dc=com'`|
|`['nagios']['objects']['commands']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['hosts']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['hostgroups']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['hostdependencies']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['hostescalations']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['hostextinfos']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['services']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['servicegroups']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['servicedependencies']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['serviceescalations']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['serviceextinfos']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['contacts']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['contactgroups']`|Array|for full customization.|`[]`|
|`['nagios']['objects']['timeperiods']`|Array|for full customization.|`[]`|
|`['nagios']['NagAconda']['version']`|String|for check_ganglia_metric|`'0.1.4'`|
|`['nagios']['check_ganglia_metric']['enabled']`|Boolean||`false`|
|`['nagios']['check_ganglia_metric']['gmetad_host']`|String||`'localhost'`|
|`['nagios']['nrpe']['allowed_hosts']`|String||`'127.0.0.1'`|
|`['nagios']['nrpe']['with_smartmontools']`|Boolean||`false`|
|`['nagios']['nrpe']['check_total_procs']['warn']`|String||`'100'`|
|`['nagios']['nrpe']['check_total_procs']['crit']`|String||`'200'`|
|`['nagios']['nrpe']['check_disk#{(0..3)}']['warn']`|String||`'20%'`|
|`['nagios']['nrpe']['check_disk#{(0..3)}']['crit']`|String||`'10%'`|
|`['nagios']['nrpe']['check_disk#{(0..3)}']['path']`|String||`'/'`|
|`['nagios']['nrpe']['check_disk#{(0..3)}']['extra_opts']`|String||`''`|
|`['nagios']['nrpe']['check_smart#{(0..3)}']['device']`|String||`'/dev/sda'`|
|`['nagios']['nrpe']['check_dig']['host']`|String||`'127.0.0.1'`|
|`['nagios']['nrpe']['check_dig']['lookup']`|String||`'host-a.example.com'`|
|`['nagios']['nrpe']['check_dig_in']['host']`|String||`'127.0.0.1'`|
|`['nagios']['nrpe']['check_dig_in']['lookup']`|String||`'host-b.example.com'`|
|`['nagios']['nrpe']['check_dig_ex']['host']`|String||`'127.0.0.1'`|
|`['nagios']['nrpe']['check_dig_ex']['lookup']`|String||`'www.google.com'`|
|`['nagios']['nrpe']['check_logs']['log_files']`|Array|see default.rb|`[]`|

## Usage

### nagios-grid::default
- does nothing.

### nagios-grid::nagios-base
- Nagios base installation.

### nagios-grid::nagios-nrpe-server
- installs Nagios NRPE Server.

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2016-2017, whitestar

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

### Plugins

- check_logs.pl: Copyright (c) 2005 Serge Sergeev, 
- check_mem.pl: Copyright (c) 2011 justin at techadvise.com, The MIT License (MIT)
- check_smart.pl: This script was created under contract for the US Government and is therefore Public Domain.
