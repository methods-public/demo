#<> The path to `chef-sync-ctl`.
default['chef_server_omnibus']['chef_sync_ctl_path'] = '/opt/chef-sync/bin/chef-sync-ctl'

#<> The configuration directory for chef-sync.
default['chef_server_omnibus']['sync']['config_dir'] = '/etc/chef-sync'

#<> The Chef server sync role. `:master`, `:replica`, or `:master_and_replica`
default['chef_server_omnibus']['sync']['role'] = :replica

#<> The FQDN of the Chef Server master. Only necessary if the `role` is `:replica`.
default['chef_server_omnibus']['sync']['master'] = nil

#<
# An array of hashes defining the source and destination organizations. Only necessary if the `role` is `:replica`.
# Each hash has the format `{ :source => 'SOURCE_ORG_NAME', :destination => 'DEST_ORG_NAME' }`.
# See [chef-sync.rb Settings](https://docs.chef.io/config_rb_chef_sync.html)
# documentation for more information.
#>
default['chef_server_omnibus']['sync']['organizations'] = []

#<
# Indicates whether an attempt to bootstrap the Chef server is made.
# Generally only enabled on systems that have bootstrap enabled via a server entry.
#>
default['chef_server_omnibus']['sync']['bootstrap'] = nil

#<> The Chef Server base path.
default['chef_server_omnibus']['sync']['chef_base_path'] = nil

#<> The install path for chef-sync.
default['chef_server_omnibus']['sync']['install_path'] = nil

#<
# Configuration hash. The hash key within `node['chef_server_omnibus']['sync']['config']` should match the
# chef-sync.rb configuration key. For example, if the chef-sync.rb
# configuration is `ec_sync_client['dir'] = '/var/opt/chef-sync/ec_sync_client'`, the cookbook
# attribute would be
# `node['chef_server_omnibus']['sync']['config']['ec_sync_client']['dir'] = '/var/opt/chef-sync/ec_sync_client'`.
# See [chef-sync.rb Settings](https://docs.chef.io/config_rb_chef_sync.html)
# documentation for more information.
#>
default['chef_server_omnibus']['sync']['config'] = {}
