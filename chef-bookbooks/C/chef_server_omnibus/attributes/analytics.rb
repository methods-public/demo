#<> The path to `opscode-analytics-ctl`.
default['chef_server_omnibus']['analytics_ctl_path'] = '/opt/opscode-analytics/bin/opscode-analytics-ctl'

#<> The configuration directory
default['chef_server_omnibus']['analytics']['config_dir'] = '/etc/opscode-analytics'

#<> The API FQDN of the Chef Analytics Server.
default['chef_server_omnibus']['analytics']['analytics_fqdn'] = node['fqdn']

#<> The topology of the Chef Analytics Server.
default['chef_server_omnibus']['analytics']['topology'] = 'standalone'

#<
# Configuration hash. The hash key within `node['chef_server_omnibus']['analytics']['config']` should match the
# opscode-analytics.rb configuration key. For example, if the opscode-analytics.rb
# configuration is `actions_consumer['hipchat_room'] = 'my_room'`, the cookbook
# attribute would be
# `node['chef_server_omnibus']['analytics']['config']['actions_consumer']['hipchat_room'] = 'my_room'`.
# See [opscode-analytics.rb Settings](http://docs.chef.io/server/config_rb_analytics.html)
# documentation for more information.
#>
default['chef_server_omnibus']['analytics']['config'] = {}
