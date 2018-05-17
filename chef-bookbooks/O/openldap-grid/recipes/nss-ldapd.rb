#
# Cookbook Name:: openldap-grid
# Recipe:: nss-ldapd
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

nslcd_conf_keys = [
  'threads',
  #'uid',
  #'gid',
  'uri',
  'ldap_version',
  'binddn',
  'bindpw',
  'rootpwmoddn',
  'sasl_mech',
  'sasl_realm',
  'sasl_authcid',
  'sasl_authzid',
  'sasl_secprops',
  'base',
  'scope',
  'deref',
  'referrals',
  'filter',
  'map',
  'bind_timelimit',
  'timelimit',
  'idle_timelimit',
  'reconnect_sleeptime',
  'reconnect_retrytime',
  'ssl',
  'tls_reqcert',
  'tls_cacertdir',
  'tls_cacertfile',
  'tls_randfile',
  'tls_ciphers',
  'tls_cert',
  'tls_key',
  'pagesize',
  'nss_initgroups_ignoreusers',
  'pam_authz_search',
]

tls_cacertfile = node['openldap']['nss-ldapd']['tls_cacertfile']
if node['openldap']['with_ssl_cert_cookbook'] \
  && (tls_cacertfile.nil? || tls_cacertfile.empty?)
  ::Chef::Recipe.send(:include, SSLCert::Helper)
  node.force_override['openldap']['nss-ldapd']['tls_cacertfile'] \
    = ca_cert_path(node['openldap']['ssl_cert']['ca_name'])
end

case node['platform_family']
when 'debian'
  %w(
    libnss-ldapd
    nscd
  ).each {|pkg|
    package pkg do
      action :install
    end
  }

  service 'nslcd' do
    action [:enable]
    supports status: true, restart: true, reload: false
  end

  resources(service: 'nscd') rescue service 'nscd' do
    action [:enable]
    supports status: true, restart: true, reload: false
  end

  template '/etc/nslcd.conf' do
    source 'etc/nslcd.conf'
    owner 'root'
    group 'nslcd'
    mode '0640'
    variables nslcd_conf_keys: nslcd_conf_keys
    notifies :restart, 'service[nslcd]'
    notifies :restart, 'service[nscd]'
  end
when 'rhel'
  package 'nss-pam-ldapd' do
    action :install
  end

  service 'nslcd' do
    action [:enable]
    supports status: true, restart: true, reload: true
  end

  resources(service: 'nscd') rescue service 'nscd' do
    action [:enable]
    supports status: true, restart: true, reload: true
  end

  template '/etc/nslcd.conf' do
    source 'etc/nslcd.conf'
    owner 'root'
    group 'root'
    mode '0600'
    variables nslcd_conf_keys: nslcd_conf_keys
    notifies :restart, 'service[nslcd]'
    notifies :restart, 'service[nscd]'
  end
end

ruby_block 'configuring_nameservices' do
  block do
    conf_file = '/etc/nsswitch.conf'
    nameservices = node['openldap']['ldap_lookup_nameservices']
    if !nameservices.nil? && !nameservices.empty?
      open(conf_file, 'r+') {|file|
        file.flock(File::LOCK_EX)
        is_modified = false
        buf = ''
        file.each {|line|
          if line =~ /^(\w+):\s+(.*)$/ \
            && nameservices.include?($1) && !$2.include?('ldap')
            line.chomp! << " ldap\n"
            is_modified = true
          end
          buf << line
        }
        if is_modified
          print "\nnew #{conf_file}: [#{buf}]"
          file.rewind
          file.puts buf
          file.truncate(file.tell)
        end
      }
    end
  end
  action :run
  notifies :restart, 'service[nscd]'
end
