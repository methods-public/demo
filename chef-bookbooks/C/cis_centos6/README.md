# CIS CentOS 6 Cookbook

This cookbook implements server hardening as specified by the [CIS Benchmark for CentOS 6, version 1.1.0](https://benchmarks.cisecurity.org/downloads/show-single/?file=centos6.110). The sections of the benchmark are largely split into different recipes:

* 1. Install Updates, Patches and Additional Security Software - `recipes/additional_security.rb`, `recipes/filesystem.rb`
* 2. OS Services - `recipes/legacy_services.rb`
* 3. Special Purpose Services - `recipes/special_purpose_services.rb`
* 4. Network Configuration and Firewalls - `recipes/network.rb`
* 5. Logging and Auditing - `recipes/logging.rb`
* 6. System Access, Authentication and Authorization - `recipes/cron.rb`, `recipes/sshd.rb`, `recipes/pam.rb`
* 7. User Accounts and Environment - `recipes/environment.rb`
* 8. Warning Banners - `recipes/banners.rb`
* 9. System Maintenance - `recipes/system_file_permissions.rb`

This cookbook cannot cover everything in the benchmark. For example server maintenance tasks like "1.2.3 Obtain Software Package Updates with yum" or auditing tasks like "9.1.1 Verify System File Permissions". It does aim to cover all server configuration items that can be done during the course of a Chef run.

It is recommended that you reboot the system after applying changes for the first time as some changes require a system reboot to take effect.

## Pre-requisites

This cookbook does not perform partitioning of the filesystem. This will need to be done before the cookbook is run so that the filesystem recipe can apply updates to those entries in the fstab. See section 1.1 of the benchmark for details of which filesystems to create. The filesystem recipe will apply the options.

This cookbook enables iptables (as required by the benchmark) but does not configure any rules. Consider configuring firewall rules with another cookbook, for example the [firewall](https://supermarket.chef.io/cookbooks/firewall) cookbook.

## Attributes

Not all servers will be able to support all parts of the benchmark being applied. Most of the attributes are provided to customise or disable sections of the hardening. All of the hardening is enabled by default.

## Testing

This cookbook has been applied to servers and tested using [Nessus](https://www.tenable.com/products/nessus-vulnerability-scanner) to ensure that the benchmark items have been implemented correctly.

It has been tested with Chef 12.7.2 but may work with earlier releases. It should work with later (minor) releases.

There is not currently any unit testing, integration testing or style linting.

## Authors

Developed at [Huddle](https://www.huddle.com/) by [Richard Owen](https://github.com/richardowen) and [Eddie Li](https://github.com/xdl).

## License

The cookbook is licensed under the MIT license:

    The MIT License (MIT)

    Copyright (c) 2016 Huddle

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
