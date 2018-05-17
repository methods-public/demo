Description
===========
yum-updatesd provides notification of updates which are available to be applied to your system. This notification can be done either via syslog, email or over dbus.

Requirements
------------
* Chef 11 or higher
* Ruby 1.9 (preferably from the Chef full-stack installer)
* RHEL5, RHEL6, or other platforms within the family

Attributes
----------
The following attributes are set by default

```
#Main
# Number of seconds to wait between checks for available updates. 
default['yum-updatesd']['run_interval'] = 3600
# Minimum number of seconds between update information refreshes to avoid hitting the server too often. 
default['yum-updatesd']['updaterefresh'] = 600
# List of ways to emit update notification. Valid values are 'email', 'dbus' and 'syslog'. 
default['yum-updatesd']['emit_via'] = syslog
# Boolean option to decide whether or not updates should be automatically applied. Defaults to False. 
default['yum-updatesd']['do_update'] = False
# Boolean option to decide whether or not updates should be automatically downloaded. Defaults to False. 
default['yum-updatesd']['do_download'] = False
# Boolean option to automatically download dependencies of packages which need updating as well. Defaults to False. 
default['yum-updatesd']['do_download_deps'] = False
# Boolen option to listen via dbus to give out update information/check for new updates
default['dbus_listener']['do_download_deps'] = False

#Mail Options
# List of email addresses to send update notification to. Defaults to 'root@localhost'. 
default['yum-updatesd']['email_to'] = 'root@localhost' 
# Email address for update notifications to be from. Defaults to 'yum-updatesd@localhost'. 
default['yum-updatesd']['email_from'] = 'yum-updatesd@localhost'
# SMTP server to use when sending mail, host or a host:port string. Defaults to 'localhost:25'. 
default['yum-updatesd']['smtp_server'] = 'localhost:25'

#Syslog Options
# What syslog facility should be used. Defaults to 'DAEMON'. 
default['yum-updatesd']['syslog_facility'] = 'DAEMON'
# Level of syslog messages. Defaults to 'WARN'. 
default['yum-updatesd']['syslog_level'] =  'WARN'
```

Usage
-----
#### yum-updatesd
Just include `yum-updatesd` in your node's `run_list`:

License & Authors
-----------------
- Author:: David Hofmann (<elmic11111@gmail.com>)

```text
Copyright:: 2015 David Hofmann

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