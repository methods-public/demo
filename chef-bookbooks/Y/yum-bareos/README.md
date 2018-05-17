# yum-bareos Cookbook
[![Build Status](https://travis-ci.org/anthonyneto/chef-yum-bareos.svg?branch=master)](http://travis-ci.org/anthonyneto/chef-yum-bareos) [![Cookbook Version](https://img.shields.io/cookbook/v/yum-bareos.svg)](https://supermarket.chef.io/cookbooks/yum-bareos)

## Requirements
- Chef 11+
- yum version 3.2.0 or higher
- EPEL repository
- yum-plugin-priorities package

### Platforms
- Fedora and RHEL based distributions (RHEL, CentOS, and Scientific Linux) are supported

## Attributes
The following attributes are set by default

```ruby
default['yum']['bareos']['description'] = 'BareOS Repository'
default['yum']['bareos']['baseurl'] = 'http://download.bareos.org/bareos/release/latest/CentOS_$releasever/$basearch'
default['yum']['bareos']['gpgkey'] = 'http://download.bareos.org/bareos/release/latest/CentOS_$releasever/repomd.xml.key'
default['yum']['bareos']['gpgcheck'] = true
default['yum']['bareos']['enabled'] = true
default['yum']['bareos']['priority'] = '90'
default['yum']['bareos']['managed'] = true
```

## Maintainers

* Anthony Neto (<anthony.neto@gmail.com>)

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
