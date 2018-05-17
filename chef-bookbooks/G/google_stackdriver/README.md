# [Google Stackdriver](http://www.stackdriver.com/) Chef cookbook

[![Circle CI](https://circleci.com/gh/tablexi/chef-google_stackdriver.svg?style=svg)](https://circleci.com/gh/tablexi/chef-google_stackdriver)

Handles the setup and installation of the google stackdriver agent and plugins.

# Requirements

Supports CentOS, RHEL, Amazon, and Ubuntu linux distributions.

# Usage

Add stackdriver::default to your run list.

To use the plugins, change the enable attribute to true and add the stackdriver::plugins recipe to your run list.

# Attributes

## default

* action - Install (:install) or install and ensure stackdriver_agent is the latest version (:upgrade).  Default :upgrade.
* repo_url - location of the package repository.
* api_key - set the api key from your stackdriver account.
* config_collectd - should stackdriver handle collectd.conf autogeneration.  Default is true.
* enable - If set to false, the stackdriver agent will be disabled.  Default is true.
* gen_hostid - generate a host id. [Link](http://support.stackdriver.com/customer/portal/articles/1491718-server-monitoring-beta-)
* gpg_key - location of the Stackdriver gpg-key for package authentication.
* service_account - A hash of various GCM configs. Most of these are directly taken from the [GCM credentials json file](https://cloud.google.com/monitoring/agent/install-agent#private_key_authorization). If you want this cookbook to manage the credentials file, all attributes except file_provided are mandatory.
  * file_provided - If you are poviding the google credentials file (application_default_credentials) outside of this cookbook, set to true. Default is false.
  * client_email - default is nil
  * client_id - default is nil
  * client_x509_cert_url - default is nil
  * private_key - default is nil
  * private_key_id - default is nil
  * project_id - default is nil
  * x509_cert_url - default is nil
* tags - set tags for your instance. [Link](http://support.stackdriver.com/customer/portal/articles/1491718-server-monitoring-beta-)

## plugins

`node['stackdriver']['plugins']`

### apache

* enable - enable the apache plugin.  Default is false.
* mod_status_url - Mod status URL for apache. Default = http://127.0.0.1/server-status?auto
* user - Mod status username for apache plugin.
* password - Mod status password for apache plugin.

### elasticsearch

* enable - enable the elasticsearch plugin. Default is false.
* http - elasticsearch protocol to use
* url - elasticsearch node url
* request_stats - the stats request path
* request_health - the health request path
* package - which yajl package to install

**NOTE**: This will get statistics for the entire cluster.

### memcached

* enable - enable the memcached plugin.  Default is false.
* host - location of the memcached instance.
* port - port for the memcached instance.

### mongodb

* enable - enable the mongodb plugin. Default is false.
* host - location of the mongodb instance.
* port - port of the mongodb isntance.
* username - if a username is required for access.
* password - if a password is required for access.
* secondary_query - all dbStat queries will be executed on a secondary node to avoid performance hits to the main db while adding a bit of latency to the metric data due to the eventual consistent nature of secondary nodes.  Default is false.

### nginx

* enable - enable the nginx plugin. Default is false.
* url - location of the nginx_status output.
* username - if a username is required for access.
password - if a password is required for access.

### redis

* enable - enable the redis plugin.  Default is false.
* package - install redis package dependency
* node - name of the redis node
* host - location of the redis instance.
* port - port for the redis instance.
* timeout - time to wait for missing values.

**NOTE**: The redis plugin requires manually running the yum-epel::default recipe on RHEL or other platforms within the family.

# Recipes

stackdriver::default - sets up the repository and installs the stackdriver agent.
stackdriver::plugins - handles plugin configuration for compatible collectd plugins.

# Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

# Author

Author:: TABLE XI (<sysadmins@tablexi.com>)

# Contributors

* Kevin Reedy (<kevin@bellycard.com>)
* Christian Vozar (<christian@bellycard.com>)
* Enrico Stahn (<mail@enricostahn.com>)
* akshah123
