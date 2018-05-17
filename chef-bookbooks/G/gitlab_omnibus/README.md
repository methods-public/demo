# Description

Install and configure GitLab and GitLab CI using GitLab Omnibus packages. GitLab
Omnibus packages contain all dependencies needed to run GitLab including Ruby,
PostgreSQL database, etc.

[Issue Tracker](https://gitlab.com/dblessing/chef-gitlab_omnibus/issues)

### Note for Debian 7 users

The `packagecloud` cookbook requires the `apt-transport-https` package. During
integration testing Debian 7.8 required an `apt-get update` in order to download
and install this package. If you get an error about installing this package, try
running `apt-get update` and then run the recipe again. Unfortunately, there wasn't
a clean way to automatically resolve this issue.

## Getting Started

By default, this cookbook does not require any attributes to be set. Simply
include this recipe in a wrapper cookbook or on a node and GitLab will be
installed and configured with `external_url` set to `https://#{node['fqdn']}`.
Override `node['gitlab_omnibus']['external_url']` if the default doesn't fit
your needs.

GitLab Container Registry is not enabled/configured by default. Set
`node['gitlab_omnibus']['registry_external_url']` to enable the container registry.

All other configuration values default to the values specified in the GitLab
Omnibus package. See
[gitlab.rb.template](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template)
in the GitLab Omnibus repository for default values. For each configuration
key in the template file there is a configuration hash in this cookbook. For
example, to set `gitlab_rails['gitlab_ssh_host']` use
`node['gitlab_omnibus']['gitlab_rails']['gitlab_ssh_host'] = ''`. Similarly,
to set `unicorn['port']` use `node['gitlab_omnibus']['unicorn']['port'] = 8181`.

### Converting YAML configuration to Ruby hash

Values represented in YAML format in `gitlab.rb.template` should be transformed
into nested hashes before being passed in to attributes in this cookbook. One
example of this is the `gitlab_rails['ldap_servers']` configuration key (see
example below).

```ruby
{
  'main' =>
  {
    'label' => 'LDAP',
    'host' => '_your_ldap_server',
    'port'=>389,
    'uid' => 'sAMAccountName',
    'method' => 'plain',
    'bind_dn' => '_the_full_dn_of_the_user_you_will_bind_with',
    'password' => '_the_password_of_the_bind_user',
    'active_directory' => true,
    'allow_username_or_email_login' => false,
    'block_auto_created_users' => false,
    'base' => '',
    'user_filter' => '',
    'group_base' => '',
    'admin_group' => '',
    'sync_ssh_keys' => false},
  'secondary' =>
  {
    'label' => 'LDAP',
    'host' => '_your_ldap_server',
    'port'=>389,
    'uid' => 'sAMAccountName',
    'method' => 'plain',
    'bind_dn' => '_the_full_dn_of_the_user_you_will_bind_with',
    'password' => '_the_password_of_the_bind_user',
    'active_directory' => true,
    'allow_username_or_email_login' => false,
    'block_auto_created_users' => false,
    'base' => '',
    'user_filter' => '',
    'group_base' => '',
    'admin_group' => '',
    'sync_ssh_keys' => false
  }
}
```

Luckily there is an extremely easy way to convert an example from `gitlab.rb` into a Ruby hash. First,
open `irb` in a terminal window and require `yaml` library. Copy a YAML example (including `YAML.load` from `gitlab.rb` and paste
into the `irb` window. Press enter and you should get a Ruby hash returned.

```
$ irb -r 'yaml'
irb(main):001:0> YAML.load <<-'EOS' # remember to close this block with 'EOS' below
irb(main):002:0' main: # 'main' is the GitLab 'provider ID' of this LDAP server
irb(main):003:0'   label: 'LDAP'
irb(main):004:0'   host: '_your_ldap_server'
irb(main):005:0'   port: 389
irb(main):006:0'   uid: 'sAMAccountName'
irb(main):007:0'   method: 'plain' # "tls" or "ssl" or "plain"
irb(main):008:0'   bind_dn: '_the_full_dn_of_the_user_you_will_bind_with'
irb(main):009:0'   password: '_the_password_of_the_bind_user'
irb(main):010:0'   active_directory: true
irb(main):011:0'   allow_username_or_email_login: false
irb(main):012:0'   block_auto_created_users: false
irb(main):013:0'   base: ''
irb(main):014:0'   user_filter: ''
irb(main):015:0'   ## EE only
irb(main):016:0'   group_base: ''
irb(main):017:0'   admin_group: ''
irb(main):018:0'   sync_ssh_keys: false
irb(main):019:0' EOS
=> {"main"=>{"label"=>"LDAP", "host"=>"_your_ldap_server", "port"=>389, "uid"=>"sAMAccountName", "method"=>"plain", "bind_dn"=>"_the_full_dn_of_the_user_you_will_bind_with", "password"=>"_the_password_of_the_bind_user", "active_directory"=>true, "allow_username_or_email_login"=>false, "block_auto_created_users"=>false, "base"=>"", "user_filter"=>"", "group_base"=>"", "admin_group"=>"", "sync_ssh_keys"=>false}}
irb(main):020:0>
```

## Backups

By default this cookbook will configure a cron job to backup GitLab daily at
3:00 am. See attributes to configure custom backup options.

## Enterprise GitLab

This cookbook supports installation of GitLab EE in addition to CE. Enterprise
packages are now available via PackageCloud, too. Set
`node['gitlab_omnibus']['edition'] = 'enterprise'` and GitLab EE will be installed.
You will need to enter a license key in the admin section to continue using GitLab.

## SSL

Omnibus has some magic in it. If you set an `external_url` to some value with
'https' in it Omnibus will enable SSL in Nginx configuration. By default, this
points at `/etc/gitlab/ssl/#{node['fqdn']}.crt` for the certificate and
`/etc/gitlab/ssl/#{node['fqdn']}.key` for the private key. Users of this
cookbook should either place SSL certificates in this location or specify
a new location for certificates with
`node['gitlab_omnibus']['nginx']['ssl_certificate']` and
`node['gitlab_omnibus']['nginx']['ssl_certificate_key']`. This cookbook does
not facilitate handling of SSL certificate files. See
["Things this cookbook doesn't do"](#things-this-cookbook-doesn-t-do) below for
more information.

If GitLab CI is enabled, SSL configuration options for the CI virtual host
should be set. Set `node['gitlab_omnibus']['ci_nginx']['ssl_certificate']` and
`node['gitlab_omnibus']['ci_nginx']['ssl_certificate_key']`. The default
is the same as for GitLab - `/etc/gitlab/ssl/#{node['fqdn']}.crt` for the
certificate and `/etc/gitlab/ssl/#{node['fqdn']}.key` for the private key.

## SSH

GitLab requires OpenSSH. I suggest the
[openssh cookbook](https://supermarket.chef.io/cookbooks/openssh) for managing
SSH. Installing and configuring SSH is outside the scope of this cookbook. See
["Things this cookbook doesn't do"](#things-this-cookbook-doesn-t-do) below for
more information.

## Postfix

GitLab requires Postfix to send email. I recommend the
[postfix cookbook](https://supermarket.chef.io/cookbooks/postfix) for managing
Postfix. Installing and configuring Postfix is outside the scope of this
cookbook. See
["Things this cookbook doesn't do"](#things-this-cookbook-doesn-t-do) below for
more information.

# Requirements

## Platform:

* centos (>= 6.5)
* debian (>= 7.1)
* ubuntu (>= 12.04)

## Cookbooks:

* poise (~> 1.0)
* packagecloud (< 1.0)

# Attributes

* `node['gitlab_omnibus']['use_packagecloud']` - Use GitLab packagecloud repo. Defaults to `true`.
* `node['gitlab_omnibus']['package_name']` - The name of the GitLab Omnibus package. Determined automatically when using packagecloud
but can be customized if using an internal package repository. Defaults to `gitlab-ce`.
* `node['gitlab_omnibus']['edition']` - GitLab edition to install. `community` or `enterprise`. Defaults to `community`.
* `node['gitlab_omnibus']['version']` - Specify GitLab version to install. By default use latest version available at install time. If GitLab
is already installed and a higher version is specified the package will be upgraded. Defaults to `nil`.
* `node['gitlab_omnibus']['action']` - `:install` or `:upgrade`? Beware, `:upgrade` will install the newest version as soon
as it becomes available. Defaults to `:install`.
* `node['gitlab_omnibus']['external_url']` - URL where GitLab will be accessible. Defaults to `https://#{node['fqdn']}`.
* `node['gitlab_omnibus']['git_data_dir']` - Git data directory. If value is nil, defaults to Omnibus value of `/var/opt/gitlab/git-data`. Defaults to `nil`.
* `node['gitlab_omnibus']['gitlab_rails']` - Configuration matching `gitlab_rails['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['user']` - Configuration matching `user['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['unicorn']` - Configuration matching `unicorn['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['sidekiq']` - Configuration matching `sidekiq['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['gitlab_shell']` - Configuration matching `gitlab_shell['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['postgresql']` - Configuration matching `postgresql['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['redis']` - Configuration matching `redis['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['web_server']` - Configuration matching `web_server['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['nginx']` - Configuration matching `nginx['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['logging']` - Configuration matching `logging['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['logrotate']` - Configuration matching `logrotate['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['omnibus_gitconfig']` - Configuration matching `omnibus_gitconfig['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['high_availability']` - Configuration matching `high_availability['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['ci_external_url']` - URL where GitLab CI will be accessible. Setting this value enables/configures GitLab CI. Defaults to `nil`.
* `node['gitlab_omnibus']['gitlab_ci']` - Configuration matching `gitlab_ci['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['ci_unicorn']` - Configuration matching `ci_unicorn['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['ci_sidekiq']` - Configuration matching `ci_sidekiq['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['ci_redis']` - Configuration matching `ci_redis['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `node['gitlab_omnibus']['ci_nginx']` - Configuration matching `ci_nginx['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `default['gitlab_omnibus']['registry_external_url']` - URL where GitLab Container Registry will be accessible. Setting this value enables/configures GitLab Container Registry. Defaults to `nil`.
* `default['gitlab_omnibus']['registry']` - Configuration matching `registry['config_key']` from `gitlab.rb.template`. Defaults to `{ ... }`.
* `default['gitlab_omnibus']['registry_nginx']` - Configuration matching `registry_nginx['config_key']` from `gitlab.rb.template`.Defaults to `{ ... }`.
* `node['gitlab_omnibus']['backup']['enable']` - Configure a cron job to backup GitLab (does **NOT** backup GitLab CI)
By default GitLab Omnibus keeps backups forever. Set
node['gitlab_omnibus']['gitlab_rails']['backup_keep_time'] = '604800'
(in seconds). Defaults to `true`.
* `node['gitlab_omnibus']['backup']['command']` - The command to create a backup. CRON=1 suppresses output unless there are errors. Defaults to `CRON=1 /opt/gitlab/bin/gitlab-rake gitlab:backup:create`.
* `node['gitlab_omnibus']['backup']['user']` - The user to run the backup command as. Defaults to `root`.
* `node['gitlab_omnibus']['backup']['minute']` - The cron minute. Defaults to `0`.
* `node['gitlab_omnibus']['backup']['hour']` - The cron hour. Defaults to `3`.
* `node['gitlab_omnibus']['backup']['day']` - The cron day of the week. Defaults to `*`.
* `node['gitlab_omnibus']['backup']['month']` - The cron month. Defaults to `*`.
* `node['gitlab_omnibus']['backup']['weekday']` - The cron day of the week. Defaults to `*`.

# Recipes

* gitlab_omnibus::default

## Things this cookbook *doesn't* do:

* Manage a firewall
* Install SSH or Postfix
* Manage secrets (database passwords, SSL keys/certs, etc)

### Why not?

This is a library/application cookbook. It's sole purpose is installation
and configuration of GitLab and/or GitLab CI. The goal is to be forward
compatible with future versions of GitLab and avoid assumptions about how
users like to use Chef. Therefore, it does not validate whether configuration
hash values are valid for GitLab Omnibus, it does not require any data bags,
manage secrets, install SSL certificates, or anything else of that nature.
This leaves users free to wrap the cookbook and add those bits that work for
their environment.


## Roadmap

1. Support GitLab CI Runners


## Testing

### Code Style
To run style tests (Rubocop and Foodcritic):
`rake style`

If you want to run either Rubocop or Foodcritic separately, specify the style
test type (Rubocop = ruby, Foodcritic = chef)
`rake style:chef`
or
`rake style:ruby`

### RSpec tests
Run RSpec unit tests
`rake spec`

### Test Kitchen
Run Test Kitchen tests (these tests take quite a bit of time)
`rake integration:vagrant`


# License and Maintainer

Maintainer:: Drew Blessing (<drew.blessing@mac.com>)

License:: Apache 2.0
