#
# Cookbook Name:: cdap
# Attribute:: security
#
# Copyright © 2013-2017 Cask Data, Inc.
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

# COOK-74 and COOK-116
ssl_props = %w(security.server.ssl.enabled ssl.enabled ssl.external.enabled)
set_ssl_props = ssl_props & node['cdap']['cdap_site'].keys
# check if more than one ssl property set and use the "latest"
if set_ssl_props.length >= 1
  ssl_props.each do |prop|
    default['cdap']['cdap_site'][prop] = node['cdap']['cdap_site'][set_ssl_props.last]
  end
end

# SSL Settings
default['cdap']['cdap_security']['security.server.ssl.keystore.password'] = 'somedefaultpassword'
default['cdap']['cdap_security']['security.server.ssl.keystore.keypassword'] = 'somedefaultkeypassword'
default['cdap']['cdap_security']['security.server.ssl.keystore.path'] = "/etc/cdap/#{node['cdap']['conf_dir']}/security.jks"
default['cdap']['cdap_security']['router.ssl.keystore.password'] = 'somedefaultpassword'
default['cdap']['cdap_security']['router.ssl.keystore.keypassword'] = 'somedefaultkeypassword'
default['cdap']['cdap_security']['router.ssl.keystore.path'] = "/etc/cdap/#{node['cdap']['conf_dir']}/router.jks"
default['cdap']['cdap_security']['dashboard.ssl.key'] = "/etc/cdap/#{node['cdap']['conf_dir']}/dashboard.key"
default['cdap']['cdap_security']['dashboard.ssl.cert'] = "/etc/cdap/#{node['cdap']['conf_dir']}/dashboard.crt"

# Auth-Server Settings
if node['cdap'].key?('cdap_site') && node['cdap']['cdap_site'].key?('security.enabled') &&
   node['cdap']['cdap_site']['security.enabled'].to_s == 'true'
  default['cdap']['cdap_site']['security.auth.server.address'] = node['fqdn']
end

# realmfile creation
# node['cdap']['cdap_site']['security.authentication.handlerClassName'] must equal 'security.authentication.basic.realmfile'
# node['cdap']['cdap_site']['security.authentication.basic.realmfile'] must define the realmfile location
default['cdap']['security']['manage_realmfile'] = false
# realmfile username/passwords
# default['cdap']['security']['realmfile']['username'] = 'password'
default['cdap']['security']['realmfile'] = {}

# SSL common name
default['cdap']['security']['ssl_common_name'] = node['fqdn']

if node['cdap']['cdap_site'].key?('kerberos.auth.enabled') && node['cdap']['cdap_site']['kerberos.auth.enabled'].to_s == 'true'
  default_realm = node['krb5']['krb5_conf']['realms']['default_realm'].upcase
  # For cdap-master init script
  if node['cdap'].key?('security') && node['cdap']['security'].key?('cdap_keytab')
    default['cdap']['kerberos']['cdap_keytab'] = node['cdap']['security']['cdap_keytab']
  else
    default['cdap']['kerberos']['cdap_keytab'] = "#{node['krb5']['keytabs_dir']}/cdap.service.keytab"
    # Backwards compat
    default['cdap']['security']['cdap_keytab'] = node['cdap']['kerberos']['cdap_keytab']
  end
  if node['cdap'].key?('security') && node['cdap']['security'].key?('cdap_principal')
    default['cdap']['kerberos']['cdap_principal'] = default['cdap']['security']['cdap_principal']
  else
    default['cdap']['kerberos']['cdap_principal'] = "cdap/#{node['fqdn']}@#{default_realm}"
    # Backwards compat
    default['cdap']['security']['cdap_principal'] = node['cdap']['kerberos']['cdap_principal']
  end

  # Add cdap user to YARN container-executor.cfg's allowed.system.users
  if node['hadoop'].key?('container_executor') && node['hadoop']['container_executor'].key?('allowed.system.users')
    arr = node['hadoop']['container_executor']['allowed.system.users'].split(',')
    user =
      if node.key?('cdap') && node['cdap'].key?('kerberos') && node['cdap']['kerberos'].key?('cdap_principal') &&
         node['cdap']['kerberos']['cdap_principal'] != "cdap/#{node['fqdn']}@#{default_realm}"
        node['cdap']['kerberos']['cdap_principal'].split(%r{[@/]}).first
      else
        'cdap'
      end
    unless arr.include?(user)
      arr += [user]
      default['hadoop']['container_executor']['allowed.system.users'] = arr.join(',')
    end
  else
    default['hadoop']['container_executor']['allowed.system.users'] = 'cdap,yarn'
  end

  # Add cdap group to core-site.xml's hadoop.proxyuser.hive.groups
  if node['hadoop'].key?('core_site') && node['hadoop']['core_site'].key?('hadoop.proxyuser.hive.groups')
    arr = node['hadoop']['core_site']['hadoop.proxyuser.hive.groups'].split(',')
    group = 'cdap'
    unless arr.include?(group)
      arr += [group]
      default['hadoop']['core_site']['hadoop.proxyuser.hive.groups'] = arr.join(',')
    end
  else
    default['hadoop']['core_site']['hadoop.proxyuser.hive.groups'] = 'cdap,hadoop'
  end

  # Tell HiveServer2 to use CDAP's keytab, not Hive's
  default['hive']['hive_site']['hive.server2.authentication.kerberos.keytab'] = node['cdap']['kerberos']['cdap_keytab']
  default['hive']['hive_site']['hive.server2.authentication.kerberos.principal'] = node['cdap']['kerberos']['cdap_principal']

  # For cdap-auth-server and cdap-router
  default['cdap']['cdap_site']['cdap.master.kerberos.keytab'] = node['cdap']['kerberos']['cdap_keytab']
  default['cdap']['cdap_site']['cdap.master.kerberos.principal'] = node['cdap']['kerberos']['cdap_principal']

  # COOK-117
  default['cdap']['cdap_site']['security.keytab.path'] = "#{node['krb5']['keytabs_dir']}/${name}.headless.keytab"
end
