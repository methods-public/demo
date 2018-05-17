#
# Cookbook Name:: zabbix_agentd
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright (c) 2016 cduong13

default['zabbix_agentd']['version'] = '3.2'

default['zabbix_agentd']['repo_rpm_url'] = {
  '3.2' => {
    'centos' => {
      '7' => {
        'x86_64' => {
          'url' => 'http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/',
          'package' => 'zabbix-release-3.2-1.el7.noarch.rpm'
        }
      }
    }
  }
}

default['zabbix_agentd']['hostname'] = node['fqdn']
default['zabbix_agentd']['etc_dir'] = '/etc/zabbix'
default['zabbix_agentd']['pid_dir'] = '/var/run/zabbix'
default['zabbix_agentd']['log_dir'] = '/var/log/zabbix'
default['zabbix_agentd']['include_dir'] =
  "#{node['zabbix_agentd']['etc_dir']}/zabbix_agentd.d"
default['zabbix_agentd']['listen_port'] = '10050'
default['zabbix_agentd']['timeout'] = '3'

default['zabbix_agentd']['servers'] = ['127.0.0.1']
default['zabbix_agentd']['servers_active'] = ['127.0.0.1']
default['zabbix_agentd']['debug_level'] = '3'
default['zabbix_agentd']['enable_remote_command'] = nil
default['zabbix_agentd']['start_agents'] = '3'
default['zabbix_agentd']['logfile_size'] = '0'
