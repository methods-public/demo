# chef-symfony-parameters

[![Build Status](https://travis-ci.org/usemarkup/chef-symfony-parameters.svg?branch=master)](https://travis-ci.org/usemarkup/chef-symfony-parameters)

Cookbook to manage parameters.yml file, allows for site-cookboks/ to be used to provide the erb, configset creation to reuse for multiple instances with the same parameter

This cookbook assumes you use of https://cookbooks.opscode.com/cookbooks/data-bag-merge so secrets can be stored in an encrypted data bag

# Example
```
"symfony": {
  "configset": {
    "production": {
      "template": "parameters.yml.erb",
      "cookbook": "my-website-parameters",
      "parameters" {
        "secret": "super_secret",
        "debug": false
      },
    },
    "staging": {
      "template": "parameters.yml.erb",
      "cookbook": "my-website-parameters",
      "parameters" {
        "secret": 123456789,
        "debug": true
      }
    }
  }
  "config": {
    "staging-uat": {
      "file": "/var/www/uat/shared/app/config/parameters.yml",
      "config": "staging"
    },
   "staging-e2e": {
      "file": "/var/www/e2e/shared/app/config/parameters.yml",
      "config": "staging"
    }
  }
}
```
