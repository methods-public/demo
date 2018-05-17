hp-tools Cookbook
=================

[![Build Status](https://travis-ci.org/tas50/hp-tools.svg?branch=master)](https://travis-ci.org/tas50/hp-tools)
[![Cookbook Version](https://img.shields.io/cookbook/v/hp-tools.svg)](https://supermarket.chef.io/cookbooks/hp-tools)

This cookbook installs the HP Management tools including the HP System Management Homepage

Requirements
============
* SNMP cookbook with a configured trap server to send hardware events to
* The following RPM's need to be available in a public or private repo configured on your nodes:
    - cpqacuxe, hp-health, hp-smh-templates, hp-snmp-agents, hpacucli, hpdiags, hponcfg, hpsmh, hpvca

### Chef
* Chef 11+

### Platforms
* Tested on RHEL 6 / CentOS 6.2
* Untested, but most likely functional on Fedora, Amazon, Oracle, and Scientific Linux


Attributes
==========

None

Usage
=====
Include the default recipe on a node's runlist

License and Author
==================
```
Author:: Tim Smith(<tsmith84@gmail.com>)

Copyright:: Copyright (c) 2012 Webtrends Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
