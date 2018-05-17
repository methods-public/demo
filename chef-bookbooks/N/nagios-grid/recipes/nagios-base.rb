#
# Cookbook Name:: nagios-grid
# Recipe:: nagios-base
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

platform = node['platform']
platform_version = node['platform_version']

root_cfg_dir = nil
base_cfg_dir = nil
site_cfg_dir = nil
nagios_pkgs = nil
nagios_service = nil
httpd_service = nil

case node['platform_family']
when 'debian'
  root_cfg_dir = '/etc/nagios3'
  nagios_pkgs = [
    # Note: PHP is not php5 but php7.0 in Ubuntu 16.04 or later
    'nagios-plugins',
    'nagios-images',
  ]

  unless platform == 'debian' && platform_version >= '9.0'
    nagios_pkgs += [
      'nagios3',
    ]
  end

  if node['nagios']['with_pnp4nagios'] && platform == 'debian' && platform_version < '9.0'
    # this recipe does not support pnp4nagios on Ubuntu and the latest Debian !
    nagios_pkgs += [
      # Debian and Ubuntu 15.10, 14.04, 12.04 only.
      'pnp4nagios',
      # Debian and Ubuntu 15.10 wily only.
      'pnp4nagios-web-config-nagios3',
    ]
  end

  if node['nagios']['web']['AuthType'] == 'Kerberos'
    nagios_pkgs.push('libapache2-mod-auth-kerb')
  end

  nagios_service = 'nagios3'
  httpd_service = 'apache2'
  httpd_nagios_conf = "#{root_cfg_dir}/apache2.conf"
when 'rhel'
  root_cfg_dir = '/etc/nagios'
  nagios_pkgs = [
    'nagios',
    'nagios-plugins',
  ]

  nagios_pkgs += \
    %w(load users ping ssh ntp http disk swap procs file_age).map {|item|
      "nagios-plugins-#{item}"
    }

  if node['nagios']['with_pnp4nagios']
    include_recipe 'yum-epel'
    nagios_pkgs += [
      'pnp4nagios',
    ]
  end

  if node['nagios']['web']['AuthType'] == 'Kerberos'
    nagios_pkgs.push('mod_auth_kerb')
  end

  nagios_service = 'nagios'
  httpd_service = 'httpd'
  httpd_nagios_conf = '/etc/httpd/conf.d/nagios.conf'
end

relative_root_cfg_dir = root_cfg_dir.sub(%r{^/}, '')
base_cfg_dir = "#{root_cfg_dir}/#{node['nagios']['base_cfg_dir']}"
site_cfg_dir = "#{root_cfg_dir}/#{node['nagios']['site_cfg_dir']}"

nagios_pkgs.each {|pkg|
  resources(package: pkg) rescue package pkg do
    action :install
  end
}

nagios_action = if node['nagios']['autostart']
                  [:enable, :start]
                else
                  [:disable]
                end

service nagios_service do
  action nagios_action
  supports status: true, restart: true, reload: true
end

[
  'nagios.cfg',
  'cgi.cfg',
].each {|cfg_file|
  template "/#{relative_root_cfg_dir}/#{cfg_file}" do
    source  "#{relative_root_cfg_dir}/#{cfg_file}"
    owner 'root'
    group 'root'
    mode '0644'
    notifies :reload, "service[#{nagios_service}]" if node['nagios']['autoreload']
  end
}

directory base_cfg_dir do
  owner 'root'
  group 'root'
  mode '0755'
end

[
  'checkcommands-generic.cfg',
  #'contacts.cfg',
  'hosts-generic.cfg',
  'services-generic.cfg',
].each {|tpl|
  template "#{base_cfg_dir}/#{tpl}" do
    source  "etc/nagios3/base/#{tpl}"
    owner 'root'
    group 'root'
    mode '0644'
    notifies :reload, "service[#{nagios_service}]" if node['nagios']['autoreload']
  end
}

directory site_cfg_dir do
  owner 'root'
  group 'root'
  mode '0755'
end

[
  'hosts.cfg',
  'services.cfg',
  'contacts.cfg',
  'timeperiods.cfg',
  'checkcommands.cfg',
].each {|cfg_file|
  template "#{site_cfg_dir}/#{cfg_file}" do
    source "etc/nagios3/site/#{cfg_file}"
    owner 'root'
    group 'root'
    mode '0644'
    notifies :reload, "service[#{nagios_service}]" if node['nagios']['autoreload']
  end
}

resources(service: httpd_service) rescue service httpd_service do
  action [:enable]
  supports status: true, restart: true, reload: true
end

template httpd_nagios_conf do
  source httpd_nagios_conf.sub(%r{^/}, '')
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[#{httpd_service}]"
end

if node['nagios']['check_external_commands'] == '1'
  case node['platform_family']
  when 'debian'
=begin
External Commands
^^^^^^^^^^^^^^^^^
Nagios 3 is not configured to look for external commands in the
default configuration as a security feature. To enable external
commands, you need to allow the web server write access to the
nagios command pipe.  the simplest way of doing this is to
set check_external_commands=1 in your nagios configuration,
and then change the permissions in a way which will be maintained
across package upgrades (otherwise dpkg will overwrite your
permission changes).  The following is the recommended approach:

- activate external command checks in the nagios configuration. this
  can be done by setting check_external_commands=1 in the file
  /etc/nagios3/nagios.cfg.

- perform the following commands to change directory permissions and
  to make the changes permanent:

/etc/init.d/nagios3 stop
dpkg-statoverride --update --add nagios www-data 2710 /var/lib/nagios3/rw
dpkg-statoverride --update --add nagios nagios 751 /var/lib/nagios3
/etc/init.d/nagios3 start
=end
    override_nagios3_rw = 'nagios www-data 2710 /var/lib/nagios3/rw'
    override_nagios3    = 'nagios nagios    751 /var/lib/nagios3'
    bash 'modify_permissions_for_check_external_commands' do
      code <<-EOC
        dpkg-statoverride --update --add #{override_nagios3_rw}
        dpkg-statoverride --update --add #{override_nagios3}
      EOC
      not_if "dpkg-statoverride --list | grep '#{override_nagios3_rw}'"
      not_if "dpkg-statoverride --list | grep '#{override_nagios3}'"
      notifies :restart, "service[#{nagios_service}]" if node['nagios']['autoreload']
    end
  when 'rhel'
    bash 'modify_permissions_for_check_external_commands' do
      code <<-EOC
        chown nagios:apache /var/spool/nagios/cmd
        chmod 2710 /var/spool/nagios/cmd
        chmod  751 /var/spool/nagios
      EOC
      not_if "ls -dl /var/spool/nagios/cmd | grep 'drwx--s---' | grep 'nagios apache'"
      not_if "ls -dl /var/spool/nagios     | grep 'drwxr-x--x'"
      notifies :restart, "service[#{nagios_service}]" if node['nagios']['autoreload']
    end
  end
end

# extra check commands
if node['nagios']['check_ganglia_metric']['enabled']
  pkg = 'python-setuptools'
  resources(package: pkg) rescue package pkg do
    action :install
  end

  bash 'easy_install_upgrade_distribute' do
    code <<-EOC
      easy_install -U distribute
    EOC
    only_if { node.platform_family?('rhel') }
  end

  easy_install_package 'check_ganglia_metric' do
    action :install
  end

  easy_install_package 'NagAconda' do
    version node['nagios']['NagAconda']['version']
    action :install
  end
end
