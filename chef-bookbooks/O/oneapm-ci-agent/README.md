oneapm-ci-agent Cookbook
================

Chef recipes to deploy oneapm-ci-agent and configuration automatically.

Requirements
============
- chef >= 10.14

Platforms
---------

* Amazon Linux
* CentOS
* Debian
* RedHat
* Scientific Linux
* Ubuntu

Cookbooks
---------

The following Opscode cookbooks are dependencies:

* `apt`
* `chef_handler`
* `yum`


Recipes
=======

default
-------
Just a placeholder for now, when we have more shared components they will probably live there.

oneapm-ci-agent
--------
Installs the oneapm-ci-agent on the target system, sets the LICENSE key, and start the service to report on the local system metrics

oneapm-ci-sdk
-----------------------
Installs the language-specific libraries to interact with `onestatsd`. *Not completed yet*.

other
-----
There are many other integration-specific recipes, that are meant to assist in deploying the correct agent configuration files and dependencies for a given integration.

Usage
=====

1. Add this cookbook to your chef server, either by installing with knife or by adding it to your Berksfile:

    ```
    cookbook 'oneapm-ci-agent', '~> 0.1.0'
    ```

2. Add your LICENSE Key as a node attribute via an `environment` or `role` or by declaring it in another cookbook at a higher precedence level.
3. Associate the recipes with the desired `roles`, i.e. "role:example" should start the agent with "oneapm-ci::oneapm-ci-agent".  Here's an example role:
    
    ```
    name 'example'
    description 'Example role using Oneapm-ci'
    default_attributes(
      'oneapm-ci' => {
        'license_key' => 'license_key',
      }
    )
    run_list %w(
      recipe[oneapm-ci::oneapm-ci-agent]
    )
    ```

    And upload the role to the chef server, add your role to run_list.
    
    ```
      'run_list': [ 'role[example]' ]
    ```
     
    Or, you update the oneapm-ci-agent specific attribute with your LICENSE key and upload the updated cookbook, then add cookbook to run_list:

    ```
      'run_list': [ 'recipe[oneapm-ci-agent::oneapm-ci-agent]'] 
    ```
   
4. Wait until `chef-client` runs on the target node (or trigger chef-client manually if you're impatient)

Attribute
=========

- `license_key` - The OneAPM license key to associate your Agent's data with your organization.
- `hostname` -  Default node hostname. Force the hostname to whatever you want if you want.
- `tags` - Set the host's tags.
- `log_level` - Default INFO.
