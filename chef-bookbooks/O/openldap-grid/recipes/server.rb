#
# Cookbook Name:: openldap-grid
# Recipe:: server
#
# Copyright 2016, whitestar
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

::Chef::Recipe.send(:include, SSLCert::Helper)

case node['platform_family']
when 'debian'
  [
    'slapd',
    'ldap-utils',
    'ssl-cert',
  ].each {|pkg|
    resources(package: pkg) rescue package pkg do
      action :install
    end
  }

  # for SSL server key access
  if node['openldap']['with_ssl_cert_cookbook']
    append_members_to_key_access_group(['openldap'])
  end

  template '/etc/default/slapd' do
    source  'etc/default/slapd'
    owner 'root'
    group 'root'
    mode '0644'
  end
when 'rhel'
  [
    'openldap-servers',
    'openldap-clients',
  ].each {|pkg|
    resources(package: pkg) rescue package pkg do
      action :install
    end
  }

  # for SSL server key access
  if node['openldap']['with_ssl_cert_cookbook']
    append_members_to_key_access_group(['ldap'])
  end

  template '/etc/sysconfig/ldap' do
    source  'etc/sysconfig/ldap'
    owner 'root'
    group 'root'
    mode '0644'
  end
end

# deploy ldif file for TLS settings.
if node['openldap']['with_ssl_cert_cookbook']
  [
    '00_olc-add-ldaps.ldif',
    '00_olc-mod-ldaps.ldif',
  ].each {|ldif|
    template "/etc/ldap/#{ldif}" do
      source  "etc/ldap/#{ldif}"
      owner 'root'
      group 'root'
      mode '0644'
      helpers SSLCert::Helper
    end
  }
end

service 'slapd' do
  #action [:enable, :start]
  action [:enable]
  supports status: true, restart: true, reload: false
end

log <<-EOM
Note:
You must setup OpenLDAP configurations in the first installation:
  [Debian]
    $ sudo sudo dpkg-reconfigure -plow slapd
  [CentOS]
    edit /etc/openldap/slap.d configurations
    $ sudo service slapd restart
EOM

schema_dir = '/etc/ldap/schema'
if node['openldap']['server']['extra_schema']['samba']
  pkg = 'samba'
  resources(package: pkg) rescue package pkg do
    action :install
  end

  code_str = ''
  case node['platform_family']
  when 'debian'
    code_str = <<-"EOH"
      cp /usr/share/doc/samba/examples/LDAP/samba.schema.gz #{schema_dir}/
      cp /usr/share/doc/samba/examples/LDAP/samba.ldif.gz   #{schema_dir}/
      gunzip #{schema_dir}/samba.schema.gz
      gunzip #{schema_dir}/samba.ldif.gz
    EOH
  when 'rhel'
    code_str = <<-"EOH"
      cp /usr/share/doc/samba-*/LDAP/samba.schema #{schema_dir}/
      cp /usr/share/doc/samba-*/LDAP/samba.ldif   #{schema_dir}/
    EOH
  end

  bash 'cp_samba_schema_files' do
    code code_str
    action :run
    not_if { File.exist?("#{schema_dir}/samba.schema") }
    not_if { File.exist?("#{schema_dir}/samba.ldif") }
  end

  log <<-EOM
Note:
You must add the schema for Samba only once:
  $ sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/samba.ldif
  $ sudo ldapsearch -Y EXTERNAL -H ldapi:/// -LLL -b "cn=schema,cn=config" dn
  EOM
end
