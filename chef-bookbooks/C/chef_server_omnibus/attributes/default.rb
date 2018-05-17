#<> The configuration directory
default['chef_server_omnibus']['config_dir'] = '/etc/opscode'

#<> The path to `chef-server-ctl`.
default['chef_server_omnibus']['ctl_path'] = '/opt/opscode/bin/chef-server-ctl'

#<> The path to `opscode-manage-ctl`.
default['chef_server_omnibus']['opscode_manage_ctl_path'] = '/opt/opscode-manage/bin/opscode-manage-ctl'

#<> The path to `opscode-push-jobs-server-ctl`.
default['chef_server_omnibus']['push_jobs_ctl_path'] = '/opt/opscode-push-jobs-server/bin/opscode-push-jobs-server-ctl'

#<> The path to `opscode-reporting-ctl`.
default['chef_server_omnibus']['opscode_reporting_ctl_path'] = '/opt/opscode-reporting/bin/opscode-reporting-ctl'
#<
# The API FQDN of the Chef Server. Value should be equal to the FQDN for the
# service URI used by the Chef server.
#>
default['chef_server_omnibus']['api_fqdn'] = node['fqdn']

#<> The topology of the Chef Server.
default['chef_server_omnibus']['topology'] = 'standalone'

#<> If true, bootstrap the Chef Server.
default['chef_server_omnibus']['bootstrap'] = nil

#<> Use to set the IP version: `ipv4` or `ipv6`.
default['chef_server_omnibus']['ip_version'] = nil

#<> Email address for notification emails.
default['chef_server_omnibus']['notification_email'] = nil

#<
# Configuration hash. The hash key within `config` should match the
# chef-server.rb configuration key. For example, if the chef-server.rb
# configuration key is `bookshelf['vip'] = '127.0.0.1'`, the cookbook
# attribute would be
# `node['chef_server_omnibus']['config']['bookshelf']['vip'] = '127.0.0.1'`.
# See [chef-server.rb Settings](http://docs.chef.io/server/config_rb_server.html)
# documentation for more information.
#>
default['chef_server_omnibus']['config'] = {}
