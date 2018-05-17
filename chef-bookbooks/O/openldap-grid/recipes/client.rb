#
# Cookbook Name:: openldap-grid
# Recipe:: client
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

ldap_conf_keys = [
  'URI',
  'BASE',
  'BINDDN',
  'DEREF',
  'HOST',
  'NETWORK_TIMEOUT',
  'PORT',
  'REFERRALS',
  'SIZELIMIT',
  'TIMELIMIT',
  'TIMEOUT',
  'SASL_MECH',
  'SASL_REALM',
  'SASL_AUTHCID',
  'SASL_AUTHZID',
  'SASL_SECPROPS',
  'GSSAPI_SIGN',
  'GSSAPI_ENCRYPT',
  'GSSAPI_ALLOW_REMOTE_PRINCIPAL',
  'TLS_CACERT',
  'TLS_CACERTDIR',
  'TLS_CERT',
  'TLS_CHECKPEER',
  'TLS_KEY',
  'TLS_CIPHER_SUITE',
  'TLS_RANDFILE',
  'TLS_REQCERT',
  'TLS_CRLCHECK',
  'TLS_CRLFILE',
]

tls_cacert = node['openldap']['client']['TLS_CACERT']
if node['openldap']['with_ssl_cert_cookbook'] \
  && (tls_cacert.nil? || tls_cacert.empty?)
  ::Chef::Recipe.send(:include, SSLCert::Helper)
  node.force_override['openldap']['client']['TLS_CACERT'] \
    = ca_cert_path(node['openldap']['ssl_cert']['ca_name'])
end

case node['platform_family']
when 'debian'
  pkg = 'ldap-utils'
  resources(package: pkg) rescue package pkg do
    action :install
  end

  template '/etc/ldap/ldap.conf' do
    source 'etc/ldap/ldap.conf'
    owner 'root'
    group 'root'
    mode '0644'
    variables ldap_conf_keys: ldap_conf_keys
  end
when 'rhel'
  pkg = 'openldap-clients'
  resources(package: pkg) rescue package pkg do
    action :install
  end

  template '/etc/openldap/ldap.conf' do
    source 'etc/openldap/ldap.conf'
    owner 'root'
    group 'root'
    mode '0644'
    variables ldap_conf_keys: ldap_conf_keys
  end
end
