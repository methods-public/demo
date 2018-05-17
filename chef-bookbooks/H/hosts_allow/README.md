# hosts.allow Cookbook
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

Cookbook which configures the host.allow file.

## Platforms
The following platforms are tested using Test Kitchen:

- Ubuntu 12.04/14.04/16.04
- CentOS (RHEL) 5/6/7

## Basic Usage
The [default recipe](recipes/default.rb) gives you the ability to pass attributes to tune your hosts.allow settings.
There are currently no defaults in this cookbook so your regular distrobution provided hosts.allow file will remain intact.
You can tweak the settings in the Policefile.rb or directly using attributes.

### Recipe
```ruby
node.default['host_allow']['hosts] = { 'ssh' => 'ALL', 'ntpd' => 'ALL'}
```

### Policyfile
``` ruby
name 'host_allow'
default_source :community
cookbook 'host_allow', git: 'https://github.com/acaiafa/host-allow-cookbook'
run_list 'host_allow::default'

override['host_allow']['hosts] = { 'ssh' => 'ALL', 'ntpd' => 'ALL'}
```

