Stegosoc-windows cookbook
=====================

The Stegosoc-windows cookbook exposes the `stegosoc-windows::coon` and `stegosoc-windows::opswork_coon` recipes.

Scope
-----
This cookbook is concerned with the "wazuh agent installation".


Requirements
------------
* Chef 13 or higher


Recipes
-------
### stegosoc-windows::coon

This recipe installs a Wazuh agent and configure the Wazuh agent as a service. Wazuh Manager IP 
configuration parameters as passed from node attributes.

### stegosoc-windows::opswork_coon

This recipe runs on AWS opsworks only and installs a Wazuh agent and configure the Wazuh agent as a service. Wazuh Manager IP
parameters are passed from env variable at deploy state.

Usage
-----

### run_list

Include `'recipe[stegosoc-windows::coon]'` or `'recipe[stegosoc-windows::opswork_coon]'`to deploy through Opswork in your run_list.


Attributes
----------


#wazuh-manager config

default['stegosoc']['wazuh-manager']['ip'] = '127.0.0.1' # Private IP Override Wazuh-Manager Server-IP

default['stegosoc']['wazuh-manager']['port'] = '1515'

default['stegosoc']['coon']['agent_unique_name'] = "#{node['hostname']}"

default['stegosoc']['coon']['syscheck_frequency'] = '3600'



License & Authors
-----------------
- Author:: Aditya Doke (<aditya.doke@gmail.com>)

