# Embulk Chef Cookbook

[![Build Status](https://travis-ci.org/puckel/embulk-cookbook.svg?branch=master)](https://travis-ci.org/puckel/embulk-cookbook) [![Cookbook Version](https://img.shields.io/cookbook/v/embulk.svg)](https://supermarket.chef.io/cookbooks/embulk)

# What's Embulk?

Embulk is a parallel bulk data loader that **helps data transfer between various storages, databases, NoSQL and cloud services**.

Embulk website: http://www.embulk.org

## Requirements

## Pre-requisites & Supported Versions

[Java Runtime](https://www.java.com/en/) - This cookbook requires java, but does not provide it. Please install Java before using any recipe in this cookbook. We recommend [this cookbook](https://github.com/agileorbit-cookbooks/java) to install Java.

### Platforms

The following platforms are supported and tested with Test Kitchen:

- Ubuntu 12.04+
- CentOS 6+

Other Debian and RHEL family distributions are assumed to work.

### Chef

- Chef 12.4+

## Attributes

## Resources

### embulk_plugin

### Actions

- `install` - Install embulk plugin (default)
- `uninstall` - Uninstall embulk plugin

### Properties:

  - `version` - (optional)

## License & Authors

- Author:: Matthieu Roisil([contact@puckel.fr](mailto:contact@puckel.fr))

```text

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

# Wanna help?

Fork, improve and PR. ;-)
