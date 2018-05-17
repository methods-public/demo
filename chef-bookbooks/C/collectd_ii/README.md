[![Chef cookbook](https://img.shields.io/cookbook/v/collectd_ii.svg)]()
[![Code Climate](https://codeclimate.com/github/Stromweld/collectd_ii/badges/gpa.svg)](https://codeclimate.com/github/Stromweld/collectd_ii)
[![Issue Count](https://codeclimate.com/github/Stromweld/collectd_ii/badges/issue_count.svg)](https://codeclimate.com/github/Stromweld/collectd_ii)

# collectd_ii

## Description

Installs and configures collectd.  Much of the work in this cookbook reflects
work done by [coderanger](https://github.com/coderanger/chef-collectd) and
[realityforge](https://github.com/realityforge/chef-collectd).

This cookbook was copied from collectd-ng cookbook by Hector Castro. I updated it for chef-client 13+.

## Requirements

### Platforms

* Amazon
* CentOS
* Ubuntu

### Cookbooks

* build-essential
* yum

## Attributes

* `node['collectd_ii']['version']` - Version of collectd to install.
* `node['collectd_ii']['dir']` - Base directory for collectd.
* `node['collectd_ii']['plugins_conf_dir']`- Plugin directory for collectd.
* `node['collectd_ii']['url']` - URL to the collectd archive.
* `node['collectd_ii']['checksum']` - Checksum for the collectd archive.
* `node['collectd_ii']['interval']` - Number of seconds to wait between data reads.
* `node['collectd_ii']['read_threads']` - Number of threads performing data reads.
* `node['collectd_ii']['write_queue_limit_high']` - Upper bound on write queue size.
* `node['collectd_ii']['write_queue_limit_low']` - Lower bound on write queue size.
* `node['collectd_ii']['collect_internal_stats']` - Flag to collect internal
  collectd statistics.
* `node['collectd_ii']['name']` - Name of the node reporting statstics.
* `node['collectd_ii']['fqdnlookup']` - Flag to determine if the node should
  determine its own FQDN.
* `node['collectd_ii']['plugins']` - Mash of plugins for installation.
* `node['collectd_ii']['python_plugins']` - Mash of Python plugins for installation.
* `node['collectd_ii']['plugins_conf_dir']` - Directory for collectd plugins configuration files.
* `node['collectd_ii']['graphite_role']` – Role assigned to Graphite server for
  search.
* `node['collectd_ii']['graphite_ipaddress']` – IP address to Graphite server if
  you're trying to target one that isn't searchable.
* `node['collectd_ii']['packages']` – List of collectd packages.
* `node['collectd_ii']['configure_flag']` – Flag for enabling non-default collectd packages. 

## Recipes

* `recipe[collectd_ii]` will install collectd from source.
* `recipe[collectd_ii::attribute_driven]` will install collectd via node attributes.
* `recipe[collectd_ii::packages]` will install collectd (and other plugins) from
  packages.
* `recipe[collectd_ii::recompile]` will attempt to recompile collectd.

**Note**: You need to include the default `recipe[collectd_ii]` when using `recipe[collectd_ii:attribute_driven]` to install `collectd`.

## Usage

By default this cookbook will attempt to download collectd from collectd.org.
If your HTTP request includes Chef as the user agent, collectd.org returns an
HTTP response with a message asking you to please stop using their downloads
via Chef. It is **highly recommended** that you override
`node['collectd_ii']['url']` with your own download location for collectd.

A list of alternative download locations for collectd:

* [https://s3.amazonaws.com/collectd-5.4.1/collectd-5.4.1.tar.gz](https://s3.amazonaws.com/collectd-5.4.1/collectd-5.4.1.tar.gz) (@ahochman)

In order to configure collectd via attributes, setup your roles like:

```ruby
default_attributes(
  'collectd' => {
    'plugins' => {
      'syslog' => {
        'config' => { 'LogLevel' => 'Info' }
      },
      'disk'      => { },
      'swap'      => { },
      'memory'    => { },
      'cpu'       => { },
      'interface' => {
        'config' => { 'Interface' => 'lo', 'IgnoreSelected' => true }
      },
      'df'        => {
        'config' => {
          'ReportReserved' => false,
          'FSType' => [ 'proc', 'sysfs', 'fusectl', 'debugfs', 'devtmpfs', 'devpts', 'tmpfs' ],
          'IgnoreSelected' => true
        }
      },
      'write_graphite' => {
        'config' => {
          'Prefix' => 'servers.'
        }
      }
    }
  }
)
```
