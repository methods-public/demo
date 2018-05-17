# chef-attributes
Manipulate Chef Attributes on Node, Role or Environment Level on the fly.

[![Gem Version](https://badge.fury.io/rb/kitchen-docker.svg)](http://badge.fury.io/rb/kitchen-docker)
[![Build Status](https://travis-ci.org/ledorsapmalat/chef-attributes.svg?branch=master)](https://travis-ci.org/ledorsapmalat/chef-attributes)

# Requirements
- Chef Client 12+
- Ohai 4+
- RubyGems 1+

## Usage
Include the default recipe and override the default attributes ```default['chef']['level']['attributes']```

### wrapper cookbook
```
include_recipe 'chef-attributes::default'
```
### override attribute
```
override['chef']['level']['attributes'] = {
  'environment' => {
    'Development' => {
      'env.attribute.period.concatenated' => 'value',
      'env.attribute.period.concatenated2' => 'value'
    },
    'Production' => {
      'attribute.period.concatenated3' => 'value',
      'attribute.period.concatenated4' => 'value'
    }
  },
  'role' => {
    'dev-role' => {
      'role.attribute.period.concatenated' => 'value',
      'role.attribute.period.concatenated2' => 'value'
    },
  },
  'node' => {
    'node-101' => {
      'node.attribute.period.concatenated' => 'value',
      'node.attribute.period.concatenated2' => 'value'
    }
  }
}

```

# Platform
- CentOS, Red Hat
- Amazon Linux, Amazon
- Ubuntu, Debian

Tested on:
- CentOS 7+
- Ubuntu 16.04+

# Authors
Author:: Rodel Manalo Talampas
