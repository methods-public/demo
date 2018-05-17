#
# Cookbook Name:: openldap-grid
# Attributes:: default
#
# Copyright 2013-2016, whitestar
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

default['openldap']['with_ssl_cert_cookbook'] = false
# If node['openldap']['with_ssl_cert_cookbook'] is true,
# node['openldap']['client']['TLS_CACERT'] and ['openldap']['nss-ldapd']['tls_cacertfile']
# are overridden by the following 'ca_name' attributes.
default['openldap']['ssl_cert']['ca_name'] = nil
default['openldap']['ssl_cert']['common_name'] = node['fqdn']

default['openldap']['client']['URI'] = nil   # ldap://ldap.example.com ldap://ldap-master.example.com:666
default['openldap']['client']['BASE'] = nil  # dc=example,dc=com
default['openldap']['client']['SIZELIMIT'] = nil  # 12
default['openldap']['client']['TIMELIMIT'] = nil  # 15
default['openldap']['client']['DEREF'] = nil      # never
default['openldap']['client']['TLS_CACERT'] = nil    # /etc/ssl/certs/cacert.pem
default['openldap']['client']['TLS_REQCERT'] = nil   # never|allow|try|demand*
default['openldap']['client']['TLS_CHECKPEER'] = nil # yes*|no
default['openldap']['client']['SASL_MECH'] = nil     # GSSAPI
default['openldap']['client']['TLS_CACERTDIR'] = node.value_for_platform_family(
  'debian' => nil,
  'rhel'   => '/etc/openldap/certs'
)
#default['openldap']['client']['<ldap.conf keys>'] = ...

default['openldap']['nss-ldapd']['uri'] = 'ldap://127.0.0.1/'
default['openldap']['nss-ldapd']['base'] = 'dc=example,dc=net'
#default['openldap']['nss-ldapd']['<nslcd.conf keys>'] = ...
default['openldap']['ldap_lookup_nameservices'] = []  # e.g. ['passwd', 'group']
#default['openldap'][''] =

default['openldap']['server']['extra_schema'] = {
  'samba' => false,
}
default['openldap']['server']['ldaps'] = false
default['openldap']['server']['KRB5_KTNAME'] = nil  # e.g. '/etc/krb5.keytab'
