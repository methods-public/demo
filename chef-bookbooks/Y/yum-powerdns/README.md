# yum-powerdns Cookbook
[![Build Status](https://travis-ci.org/anthonyneto/chef-yum-powerdns.svg?branch=master)](http://travis-ci.org/anthonyneto/chef-yum-powerdns) [![Cookbook Version](https://img.shields.io/cookbook/v/yum-powerdns.svg)](https://supermarket.chef.io/cookbooks/yum-powerdns)

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
default['yum']['powerdns-auth']['description'] = 'PowerDNS Authoritative Server Repository'
default['yum']['powerdns-auth']['baseurl'] = 'http://repo.powerdns.com/centos/$basearch/$releasever/auth-master'
default['yum']['powerdns-auth']['gpgkey'] = 'https://repo.powerdns.com/CBC8B383-pub.asc'
default['yum']['powerdns-auth']['gpgcheck'] = true
default['yum']['powerdns-auth']['enabled'] = true
default['yum']['powerdns-auth']['priority'] = 90
default['yum']['powerdns-auth']['managed'] = true

default['yum']['powerdns-auth-debug']['description'] = 'PowerDNS Authoritative Server Debuginfo Repository'
default['yum']['powerdns-auth-debug']['baseurl'] = 'http://repo.powerdns.com/centos/$basearch/$releasever/auth-master/debug'
default['yum']['powerdns-auth-debug']['gpgkey'] = 'https://repo.powerdns.com/CBC8B383-pub.asc'
default['yum']['powerdns-auth-debug']['gpgcheck'] = true
default['yum']['powerdns-auth-debug']['enabled'] = false
default['yum']['powerdns-auth-debug']['priority'] = 90
default['yum']['powerdns-auth-debug']['managed'] = true

default['yum']['powerdns-rec']['description'] = 'PowerDNS Recursor Repository'
default['yum']['powerdns-rec']['baseurl'] = 'http://repo.powerdns.com/centos/$basearch/$releasever/rec-master'
default['yum']['powerdns-rec']['gpgkey'] = 'https://repo.powerdns.com/CBC8B383-pub.asc'
default['yum']['powerdns-rec']['gpgcheck'] = true
default['yum']['powerdns-rec']['enabled'] = true
default['yum']['powerdns-rec']['priority'] = 90
default['yum']['powerdns-rec']['managed'] = true

default['yum']['powerdns-rec-debug']['description'] = 'PowerDNS Recursor Debuginfo Repository'
default['yum']['powerdns-rec-debug']['baseurl'] = 'http://repo.powerdns.com/centos/$basearch/$releasever/rec-master/debug'
default['yum']['powerdns-rec-debug']['gpgkey'] = 'https://repo.powerdns.com/CBC8B383-pub.asc'
default['yum']['powerdns-rec-debug']['gpgcheck'] = true
default['yum']['powerdns-rec-debug']['enabled'] = false
default['yum']['powerdns-rec-debug']['priority'] = 90
default['yum']['powerdns-rec-debug']['managed'] = true


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
