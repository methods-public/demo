# Securetty Cookbook
=======
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

Cookbook which configures the securetty.

## Platforms
The following platforms are tested using Test Kitchen:

- CentOS (RHEL) 5/6/7

## Basic Usage
The [default recipe](recipes/default.rb) gives you the ability to pass attributes to add values to your securetty config.
There are currently a few  defaults in this cookbook(path and template source). However your regular distrobution provided securetty file will remain intact.
You can tweak the settings in the Policefile.rb or directly using attributes. You can add options to the array and that is all you need to do.

### Recipe
```ruby
node.default['securetty']['ttys'] = [ 'console', 'vc/1', 'vc/2' ]
```

### Policyfile
``` ruby
name 'securetty'
default_source :community
cookbook 'securetty', git: 'https://github.com/acaiafa/securetty-cookbook'
run_list 'securetty::default'

node.default['securetty']['ttys'] = [ 'console', 'vc/1', 'vc/2' ]
```
