# yum-virtualbox Cookbook
[![Build Status](https://travis-ci.org/chasebolt/chef-yum-virtualbox.svg?branch=master)](http://travis-ci.org/chasebolt/chef-yum-virtualbox) [![Cookbook Version](https://img.shields.io/cookbook/v/yum-virtualbox.svg)](https://supermarket.chef.io/cookbooks/yum-virtualbox)

The yum-virtualbox cookbook takes over management of the default repositoryids used with the official virtualbox repositories. It allows attribute manipulation of the `virtualbox` yum channel.

## Requirements
- Chef 11+
- yum version 3.2.0 or higher

### Platforms
- Fedora and RHEL based distributions (RHEL, CentOS, and Scientific Linux) are supported

## Attributes
The following attributes are set by default

```ruby
default['yum']['virtualbox']['description'] = 'VirtualBox'
default['yum']['virtualbox']['baseurl'] = "http://download.virtualbox.org/virtualbox/rpm/el/#{node['platform_version'].to_i}/$basearch"
default['yum']['virtualbox']['gpgkey'] = 'https://www.virtualbox.org/download/oracle_vbox.asc'
default['yum']['virtualbox']['gpgcheck'] = true
default['yum']['virtualbox']['repo_gpgcheck'] = true
default['yum']['virtualbox']['enabled'] = true
default['yum']['virtualbox']['managed'] = true
```

## Recipes
- default - Walks through node attributes and feeds a yum_resource
- parameters. The following is an example a resource generated by the
- recipe during compilation.

```ruby
  yum_repository 'virtualbox' do
    baseurl "http://download.virtualbox.org/virtualbox/rpm/el/#{node['platform_version'].to_i}/$basearch"
    description 'VirtualBox'
    enabled true
    gpgcheck true
    repo_gpgcheck true
    gpgkey 'https://www.virtualbox.org/download/oracle_vbox.asc'
  end
```

## Usage Example
To disable the virtualbox repository through a Role or Environment definition

```ruby
default_attributes(
  :yum => {
    :virtualbox => {
      :enabled => {
        false
       }
     }
   }
 )
```

To enable the virtualbox repository with a wrapper cookbook, place the following in a recipe:

```ruby
node.default['yum']['virtualbox']['enabled'] = true
include_recipe 'yum-virtualbox'
```

## More Examples
Point the base and updates repositories at an internally hosted server.

```ruby
node.default['yum']['virtualbox']['enabled'] = true
node.default['yum']['virtualbox']['mirrorlist'] = nil
node.default['yum']['virtualbox']['baseurl'] = 'https://internal.example.com/virtualbox/6/os/x86_64'
node.default['yum']['virtualbox']['sslverify'] = false

include_recipe 'yum-virtualbox'
```

## Maintainers

* Chase Bolt (<chase.bolt@gmail.com>)

## License
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.