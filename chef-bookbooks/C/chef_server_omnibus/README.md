# Description

A simple cookbook for installing and configuring Chef Server, including
Chef Server Enterprise add-ons.

# Getting Started

## Chef Server Core

Include the default recipe to install `chef-server-core` and render the `/etc/opscode/chef-server.rb`
configuration file. By default, `api_fqdn` is set to `node['fqdn']` and `topology`
is set to `standalone`. No attributes are required.

Configuration directives in the
[chef-server.rb Settings](http://docs.chef.io/server/config_rb_server.html) documentation under
[Recommended Settings](http://docs.chef.io/server/config_rb_server.html#recommended-settings)
each have specific node attributes. For example, to set `api_fqdn` use
`node.default['chef_server_omnibus']['api_fqdn'] = 'chef.example.com'`.

For the additional configuration keys there is a configuration
hash in this cookbook `node['chef_server_omnibus']['config']`. For example, to set `bookshelf['vip']` use
`node.default['chef_server_omnibus']['config']['bookshelf']['vip'] = '127.0.0.1'`.
Similarly, to set `nginx['ssl_ciphers']` use
`node.default['chef_server_omnibus']['config']['nginx']['ssl_ciphers'] = 'TLSv1.2'`.

See [chef-server.rb Settings](http://docs.chef.io/server/config_rb_server.html)
documentation for more information on configuration options.

## Enterprise Add-Ons

Chef Manage, Reporting, and Push Jobs are enterprise add-ons. To install the add-ons. Put the
corresponding recipe in your Chef Server's runlist. None of the three add-ons here require any
node attributes.

* `chef_server_omnibus::manage`
* `chef_server_omnibus::push_jobs`
* `chef_server_omnibus::reporting`

### Note for `chef_server_omnibus::reporting`

Reporting add-on requires the Manage interface. Therefore, the `chef_server_omnibus::reporting` recipe includes
`chef_server_omnibus::manage`.

### Note for `chef_server_omnibus::push_jobs`

This recipe installs push jobs server. All nodes will also need the push jobs client. Use the
[push-jobs](https://supermarket.chef.io/cookbooks/push-jobs) cookbook from the supermarket to manage client
installation.

## Analytics Server

Chef Analytics is also an Enterprise add-on but it runs as a separate server (technically, it can be combined with
Chef Server). By contrast, all of the add-ons above *must* run on the same server as Chef Server core. To install Chef
Analytics, include `chef_server_omnibus::analytics` recipe. By default, `analytics_fqdn` and `topology`
are set. Set other Analytics configuration options using `node.default['chef_server_omnibus']['analytics']['config']` hash
in exactly the same way as described above for the `chef-server.rb` file.

To connect Analytics to the Chef Server some additional configuration is required on the Chef Server node. Add the
following node attributes on the Chef Server, changing values as appropriate:

```ruby
node.default['chef_server_omnibus']['config']['oc_id']['applications'] = {
  'analytics' => {
    'redirect_uri' => 'https://<analytics_fqdn>/'
  }
}

node.default['chef_server_omnibus']['config']['rabbitmq']['vip'] = '<ip_of_chef_server>'
node.default['chef_server_omnibus']['config']['rabbitmq']['node_ip_address'] = '0.0.0.0'
```

Note: If the above configuration changes on the Chef Server the contents of `/etc/opscode-analytics` will
likely need copied to the Analytics server and then run `opscode-analytics-ctl reconfigure`.

## Replication/Chef Sync

From Chef documentation: "Chef replication provides a way to asynchronously distribute cookbook, environment,
role, and data bag data from a single, primary Chef server to one (or more) replicas of that Chef server."

From experience, Chef replication requires advanced configuration and great understanding of how Chef server works.
Make sure to explore replication and its configuration before using this cookbook to configure it. Also note that since
Chef replication requires files/directories to be copied from master to replicas this cookbook does not
facilitate that. Files will have to be copied manually or use a wrapper cookbook with `chef-provisioning` to move
files around.

To install the `chef-sync` add-on, include the `chef_server_omnibus::sync` recipe on any master or replica server.
For the best up to date information on Chef Sync/Replication see
[Chef Replication](https://docs.chef.io/server_replication.html) documentation. At least you will need to configure the
following node attributes.

* `node['chef_server_omnibus']['sync']['role']`
* `node['chef_server_omnibus']['sync']['master']` (if role is `:replica` or `:master_and_replica`)
* `node['chef_server_omnibus']['sync']['organizations']` (if role is `:replica` or `:master_and_replica`)

For the additional configuration keys there is a configuration hash in this cookbook
`node['chef_server_omnibus']['sync']['config']`. For example, to set
`ec_sync_client['dir'] = '/var/opt/chef-sync/ec_sync_client'` use
`node.default['chef_server_omnibus']['sync']['config']['ec_sync_client']['dir'] = '/var/opt/chef-sync/ec_sync_client'`.

# Requirements

## Platform:

*No platforms defined*

## Cookbooks:

* chef-server-ingredient (~> 0.3)
* poise (~> 1.0)

# Attributes

* `node['chef_server_omnibus']['analytics_ctl_path']` - The path to `opscode-analytics-ctl`. Defaults to `/opt/opscode-analytics/bin/opscode-analytics-ctl`.
* `node['chef_server_omnibus']['analytics']['config_dir']` - The configuration directory. Defaults to `/etc/opscode-analytics`.
* `node['chef_server_omnibus']['analytics']['analytics_fqdn']` - The API FQDN of the Chef Analytics Server. Defaults to `node['fqdn']`.
* `node['chef_server_omnibus']['analytics']['topology']` - The topology of the Chef Analytics Server. Defaults to `standalone`.
* `node['chef_server_omnibus']['analytics']['config']` - Configuration hash. The hash key within `node['chef_server_omnibus']['analytics']['config']` should match the
opscode-analytics.rb configuration key. For example, if the opscode-analytics.rb
configuration is `actions_consumer['hipchat_room'] = 'my_room'`, the cookbook
attribute would be
`node['chef_server_omnibus']['analytics']['config']['actions_consumer']['hipchat_room'] = 'my_room'`.
See [opscode-analytics.rb Settings](http://docs.chef.io/server/config_rb_analytics.html)
documentation for more information. Defaults to `{ ... }`.
* `node['chef_server_omnibus']['config_dir']` - The configuration directory. Defaults to `/etc/opscode`.
* `node['chef_server_omnibus']['ctl_path']` - The path to `chef-server-ctl`. Defaults to `/opt/opscode/bin/chef-server-ctl`.
* `node['chef_server_omnibus']['opscode_manage_ctl_path']` - The path to `opscode-manage-ctl`. Defaults to `/opt/opscode-manage/bin/opscode-manage-ctl`.
* `node['chef_server_omnibus']['push_jobs_ctl_path']` - The path to `opscode-push-jobs-server-ctl`. Defaults to `/opt/opscode-push-jobs-server/bin/opscode-push-jobs-server-ctl`.
* `node['chef_server_omnibus']['opscode_reporting_ctl_path']` - The path to `opscode-reporting-ctl`. Defaults to `/opt/opscode-reporting/bin/opscode-reporting-ctl`.
* `node['chef_server_omnibus']['api_fqdn']` - The API FQDN of the Chef Server. Value should be equal to the FQDN for the
service URI used by the Chef server. Defaults to `node['fqdn']`.
* `node['chef_server_omnibus']['topology']` - The topology of the Chef Server. Defaults to `standalone`.
* `node['chef_server_omnibus']['bootstrap']` - If true, bootstrap the Chef Server. Defaults to `nil`.
* `node['chef_server_omnibus']['ip_version']` - Use to set the IP version: `ipv4` or `ipv6`. Defaults to `nil`.
* `node['chef_server_omnibus']['notification_email']` - Email address for notification emails. Defaults to `nil`.
* `node['chef_server_omnibus']['config']` - Configuration hash. The hash key within `config` should match the
chef-server.rb configuration key. For example, if the chef-server.rb
configuration key is `bookshelf['vip'] = '127.0.0.1'`, the cookbook
attribute would be
`node['chef_server_omnibus']['config']['bookshelf']['vip'] = '127.0.0.1'`.
See [chef-server.rb Settings](http://docs.chef.io/server/config_rb_server.html)
documentation for more information. Defaults to `{ ... }`.
* `node['chef_server_omnibus']['chef_sync_ctl_path']` - The path to `chef-sync-ctl`. Defaults to `/opt/chef-sync/bin/chef-sync-ctl`.
* `node['chef_server_omnibus']['sync']['config_dir']` - The configuration directory for chef-sync. Defaults to `/etc/chef-sync`.
* `node['chef_server_omnibus']['sync']['role']` - The Chef server sync role. `:master`, `:replica`, or `:master_and_replica`. Defaults to `:replica`.
* `node['chef_server_omnibus']['sync']['master']` - The FQDN of the Chef Server master. Only necessary if the `role` is `:replica`. Defaults to `nil`.
* `node['chef_server_omnibus']['sync']['organizations']` - An array of hashes defining the source and destination organizations. Only necessary if the `role` is `:replica`.
Each hash has the format `{ :source => 'SOURCE_ORG_NAME', :destination => 'DEST_ORG_NAME' }`.
See [chef-sync.rb Settings](https://docs.chef.io/config_rb_chef_sync.html)
documentation for more information. Defaults to `[ ... ]`.
* `node['chef_server_omnibus']['sync']['bootstrap']` - Indicates whether an attempt to bootstrap the Chef server is made.
Generally only enabled on systems that have bootstrap enabled via a server entry. Defaults to `nil`.
* `node['chef_server_omnibus']['sync']['chef_base_path']` - The Chef Server base path. Defaults to `nil`.
* `node['chef_server_omnibus']['sync']['install_path']` - The install path for chef-sync. Defaults to `nil`.
* `node['chef_server_omnibus']['sync']['config']` - Configuration hash. The hash key within `node['chef_server_omnibus']['sync']['config']` should match the
chef-sync.rb configuration key. For example, if the chef-sync.rb
configuration is `ec_sync_client['dir'] = '/var/opt/chef-sync/ec_sync_client'`, the cookbook
attribute would be
`node['chef_server_omnibus']['sync']['config']['ec_sync_client']['dir'] = '/var/opt/chef-sync/ec_sync_client'`.
See [chef-sync.rb Settings](https://docs.chef.io/config_rb_chef_sync.html)
documentation for more information. Defaults to `{ ... }`.

# Recipes

* chef_server_omnibus::analytics
* chef_server_omnibus::default
* chef_server_omnibus::manage
* chef_server_omnibus::push_jobs
* chef_server_omnibus::reporting
* chef_server_omnibus::sync

## Report issues

[Issue Tracker](https://gitlab.com/dblessing/chef_server_omnibus/issues)

If the documentation here leaves you stuck or you think you've encountered a bug, please report an issue
using the link above. The intention is for documentation to be clear enough to help anyone get up and running.
If it is not clear enough that *is* a bug - please report it.

## Things this cookbook *doesn't* do:

* Manage a firewall
* Manage secrets (database passwords, SSL keys/certs, etc)
* Orchestrate Chef Server cluster provisioning.

### Why not?

This is a library/application cookbook. It's sole purpose is installation
and configuration of Chef Server. The goal is to be forward
compatible with future versions of Chef Server and avoid assumptions about how
users like to use Chef. Therefore, it does not validate whether configuration
hash values are valid, it does not require any data bags,
manage secrets, install SSL certificates, or anything else of that nature.
This leaves users free to wrap the cookbook and add those bits that work for
their environment.

For an example of how to orchestrate Chef Server cluster provisioning, see
Chef's [Chef Server Cluster](https://github.com/opscode-cookbooks/chef-server-cluster)
cookbook.



## Roadmap

See the issue tracker for
[issues with enhancement labels](https://gitlab.com/dblessing/chef_server_omnibus/issues?label_name=enhancement)


# Testing

## Code Style
To run style tests (Rubocop and Foodcritic):
`rake style`

If you want to run either Rubocop or Foodcritic separately, specify the style
test type (Rubocop = ruby, Foodcritic = chef)
`rake style:chef`
or
`rake style:ruby`

## RSpec tests
Run RSpec unit tests
`rake spec`

## Test Kitchen
Run Test Kitchen tests (these tests take quite a bit of time)
`rake integration:vagrant`


# License and Maintainer

Maintainer:: Drew Blessing (<cookbooks@blessing.io>)

License:: Apache 2.0
