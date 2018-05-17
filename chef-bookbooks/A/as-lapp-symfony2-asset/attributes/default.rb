
#symfony2
# default['symfony2']['version'] = ''
# default['symfony2']['develop'] = true
# default['symfony2']['path'] = '/var/app2'
# default['symfony2']['maintenance']['hostip'] = '192.168.33.1'
# default['symfony2']['maintenance']['user'] = 'vagrant'
# default['symfony2']['maintenance']['group'] = 'vagrant'

#asset
# default['asset']['root_path'] = '/var/app2'
# default['asset']['maintenance']['user'] = 'vagrant'
# default['asset']['maintenance']['group'] = 'vagrant'


##################################################################
#
# default['lapp_symfony2_asset']['symfony2']['version'] = ''
# default['lapp_symfony2_asset']['php']['version'] = '5.5'
# default['lapp_symfony2_asset']['pgsql']['version'] = '9.3'
# default['lapp_symfony2_asset']['root_path'] = '/var/app2'
# default['lapp_symfony2_asset']['maintenance']['hostip'] = '192.168.33.2'
# default['lapp_symfony2_asset']['maintenance']['user'] = 'vagrant'
# default['lapp_symfony2_asset']['maintenance']['group'] = 'vagrant'
#
# default['lapp_symfony2_asset']['develop'] = true
#
# ##
#
# #php
# default['php']['version'] = node['lapp_symfony2_asset']['php']['version']
# # if node['lapp_symfony2_asset']['develop']
# #   default['php']['xdebug']['remote_enable'] = true
# # end
#
# #postgresql
# default['pgsql']['version'] = node['lapp_symfony2_asset']['pgsql']['version']
#
# #lapp
# force_default['lapp']['develop'] = false
#
# #hba
# default['pgsql']['hba'] = [
#     {:type => 'local', :database => 'all', :user => 'all', :address => '', :method => 'trust'},
#     {:type => 'host', :database => 'all', :user => 'all', :address => '0.0.0.0/0', :method => 'trust'}
# ]
#
# #conf
# default['pgsql']['conf']['listen_addresses'] = '*'
# # default['pgsql']['conf']['port'] = '5432'
# default['pgsql']['conf']['log_filename'] = 'postgresql.log'
# default['pgsql']['conf']['log_line_prefix'] = '%u%%%d[%s][%c]'
# default['pgsql']['conf']['log_timezone'] = 'Asia/Tokyo'
# default['pgsql']['conf']['log_statement'] = 'all'
# default['pgsql']['conf']['log_connections'] = 'on'
# default['pgsql']['conf']['log_disconnections'] = 'on'
#
# # node['lapp']['develop'] = true
#
# # if node['lapp_symfony2_asset']['develop']
# #   default['lapp']['develop'] = true
# # else
# #   default['lapp']['develop'] = false
# # end
#
# #symfony2
# default['symfony2']['version'] = node['lapp_symfony2_asset']['symfony2']['version']
# default['symfony2']['develop'] = node['lapp_symfony2_asset']['develop']
# default['symfony2']['path'] = node['lapp_symfony2_asset']['root_path']
# default['symfony2']['maintenance']['hostip'] = node['lapp_symfony2_asset']['maintenance']['hostip']
# default['symfony2']['maintenance']['user'] = node['lapp_symfony2_asset']['maintenance']['user']
# default['symfony2']['maintenance']['group'] = node['lapp_symfony2_asset']['maintenance']['group']
#
# # if node['lapp_symfony2_asset']['develop']
# #   default['symfony2']['develop'] = true
# # else
# #   default['symfony2']['develop'] = false
# # end
#
# #asset
# default['asset']['root_path'] = node['lapp_symfony2_asset']['root_path']
# default['asset']['maintenance']['user'] = node['lapp_symfony2_asset']['maintenance']['user']
# default['asset']['maintenance']['group'] = node['lapp_symfony2_asset']['maintenance']['group']
#
#
# # default['symfony2']['develop'] = false
# # default['symfony2']['path'] = '/var/www/app'
# # default['symfony2']['maintenance']['hostip'] = '192.168.33.1'
# # default['symfony2']['maintenance']['user'] = 'vagrant'
# # default['symfony2']['maintenance']['group'] = 'vagrant'
