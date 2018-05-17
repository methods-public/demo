Patchman
========

Linux patch management system. Used to configure and manage OS package updates on Ubuntu and RedHat family OS's.

This recipe is designed around the assumption of a two stage (test/prod) weekly patching strategy. It is not the best for every situation but I think its a good middle ground for general use.

Currently only designed to work with Debian and Redhat family of Linux OS's.

RHEL/CentOS
----------------
Utilizes yum-cron to determine exclusion list. It then uses cron to run at set time based on environment settings.


Debian/Ubuntu
----------------
Utilizes unattented-upgrades to determine type of patches, packages for exclusion lists and whether to reboot if needed. It then uses cron to run based on environment settings.


Attributes
----------------

The define arrays allow for the setting of multiple environments into either the test or prod patching configuration. An example is setting staging and qa under test to share the same patching settings.

`['patchman']['test']['define']`

`['patchman']['prod']['define']`

By default all nodes default to prod for most restrictive patching unless otherwise configured.

`['patchman']['environment'] = 'prod'`


If you want your patching to send an email you need to ensure a mail service is configured and the following two attributes are set.

`['patchman']['enable']['email'] = true`

`['patchman']['email'] = 'frank@example.com'`

Day and time attributes should be set in crontab format. such as day of week (0 - 6) (Sunday=0), hour/minutes in military time 

`['patchman']['test']['day'] = '1'`

`['patchman']['test']['time']['hour'] = '5'`

`['patchman']['test']['time']['minute'] = '45'`

By default an MOTD file is setup to show scheduled patching state (day and time of next patch). In RHEL/CentOS if a /etc/motd file is already present it will create a motd.tail that needs to then be configured to be read by your MOTD file.

`['patchman']['test']['motd_enabled'] = true`

`['patchman']['prod']['motd_enabled'] = true`


Exclude list should be setup in the same format as you would use when manually adding it to your system.

`['patchman']['test']['exclude_list'] = []`

`['patchman']['prod']['exclude_list'] = []`

Auto reboot which only works with Debian/Ubuntu is set to false by default

`['patchman']['test']['auto_reboot'] = false`

`['patchman']['prod']['auto_reboot'] = false`

By default both security and stable updated are ran, these setting allows security updates only (Debian/Ubuntu Only)

`['patchman']['debian']['test']['security_only'] = false`
`['patchman']['debian']['prod']['security_only'] = false`


License & Authors
-----------------
- Author:: Christopher Coffey (<nomad@cybermerc.org>)

```text

Copyright:: 2014 

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
