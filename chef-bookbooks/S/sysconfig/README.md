# Sysconfig Cookbook
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

Cookbook which configures Sysconfig.

## Platforms
The following platforms are tested using Test Kitchen:

- CentOS (RHEL) 5/6/7

## Basic Usage
The [default recipe](recipes/default.rb) gives you the ability to pass attributes and setup sysconfig files on the filesystem.
You can tweak the settings in the Policefile.rb or directly using attributes. All Sysconfig specific settings
should use underscores like the examples below.

### Recipe
```ruby
default['sysconfig']['servicename'] = 'something'
default['sysconfig']['something']['config']['settings']['kernel_test'] = 'something'
default['sysconfig']['something']['config']['settings']['kernel_test2'] = 'something2'
default['sysconfig']['something']['config']['settings']['kernel_test3'] = 'something3'
```

For mutliple sysconfig files you can pass as an array
```ruby
default['sysconfig']['servicename'] = ['something','something2']
default['sysconfig']['something']['config']['settings']['kernel_test'] = 'something'
default['sysconfig']['something']['config']['settings']['kernel_test2'] = 'something2'
default['sysconfig']['something']['config']['settings']['kernel_test3'] = 'something3'
default['sysconfig']['something2']['config']['settings']['kernel_test'] = 'something'
default['sysconfig']['something2']['config']['settings']['kernel_test2'] = 'something2'
default['sysconfig']['something2']['config']['settings']['kernel_test3'] = 'something3'
```

### Policyfile
``` ruby
name 'sysconfig'
default_source :community
cookbook 'sysconfig', git: 'https://github.com/acaiafa/sysconfig-cookbook'
run_list 'sysconfig::default'

default['sysconfig']['servicename'] = 'something'
default['sysconfig']['config']['settings']['kernel_test'] = 'something'
default['sysconfig']['config']['settings']['kernel_test2'] = 'something2'
default['sysconfig']['config']['settings']['kernel_test3'] = 'something3'
```

