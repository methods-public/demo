#
# default['lapp']['develop'] = false
#
# #apache2
# default['httpd']['DocumentRoot'] = '/var/www/html'
#
# #php
# default['php']['version'] = '5.6'
# if node['lapp']['develop']
# default['php']['xdebug']['remote_enable'] = true
# default['php']['xdebug']['remote_host'] = '10.0.2.2'
# # default['php']['xdebug']['remote_port'] = '9000'
# else
#     default['php']['xdebug']['remote_enable'] = false
# end
#
# #postgresql
# default['pgsql']['version'] = '9.4'
# if node['lapp']['develop']
#
#     #hba
#     default['pgsql']['hba'] = [
#         {:type => 'local', :database => 'all', :user => 'all', :address => '', :method => 'trust'},
#         {:type => 'host', :database => 'all', :user => 'all', :address => '0.0.0.0/0', :method => 'trust'}
#     ]
#
#     #conf
#     default['pgsql']['conf']['listen_addresses'] = '*'
#     # default['pgsql']['conf']['port'] = '5432'
#     default['pgsql']['conf']['log_filename'] = 'postgresql.log'
#     default['pgsql']['conf']['log_line_prefix'] = '%u%%%d[%s][%c]'
#     default['pgsql']['conf']['log_timezone'] = 'Asia/Tokyo'
#     default['pgsql']['conf']['log_statement'] = 'all'
#     default['pgsql']['conf']['log_connections'] = 'on'
#     default['pgsql']['conf']['log_disconnections'] = 'on'
# else
#
#     #hba
#     default['pgsql']['hba'] = [
#         {:type => 'local', :database => 'all', :user => 'all', :address => '', :method => 'peer'},
#         {:type => 'host', :database => 'all', :user => 'all', :address => '127.0.0.1/32', :method => 'ident'},
#         {:type => 'host', :database => 'all', :user => 'all', :address => '::1/128', :method => 'ident'}
#     ]
#
#     #conf
#     default['pgsql']['conf']['listen_addresses'] = 'localhost'
#     # default['pgsql']['conf']['port'] = '5432'
#     default['pgsql']['conf']['log_filename'] = 'postgresql-%a.log'
#     default['pgsql']['conf']['log_line_prefix'] = '< %m >'
#     default['pgsql']['conf']['log_timezone'] = 'UTC'
#     default['pgsql']['conf']['log_statement'] = 'none'
#     default['pgsql']['conf']['log_connections'] = 'off'
#     default['pgsql']['conf']['log_disconnections'] = 'off'
# end
