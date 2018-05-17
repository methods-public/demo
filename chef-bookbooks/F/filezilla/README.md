'filezilla' Cookbook
====================
Installs the latest version of the FileZilla Client and/or Server

[![GitHub version](https://badge.fury.io/gh/lancepowell%2FFileZilla.svg)](http://badge.fury.io/gh/lancepowell%2FFileZilla)
[![Code Climate](https://codeclimate.com/github/lancepowell/FileZilla/badges/gpa.svg)](https://codeclimate.com/github/lancepowell/FileZilla)

Attributes
----------

 - Windows needs a version specified, see default attributes file for specifics on how this is used.
 - Linux Distributions contain no attributes, they pull the version using the package resource

Windows Only Attributes

```ruby
default['filezilla']['client']['version'] = '3.14.1'
default['filezilla']['server']['version'] = '0.9.54'
default['filezilla']['server']['filename_version'] = '0_9_54'
```


Requirements
------------
* Chef 11+
* EPEL (Note: I am installing the EPEL with this cookbook)

In testing on ubuntu you need to run ```sudo apt-get update``` on the opscode kitchen boxes prior to the install being successful.

| Platform Family  | Requires |
| ------------- | ------------- |
| RHEL  | gnutls |
| Ubuntu | sudo apt-get update  |



Usage
-----

#### filezilla::default

Include the default recipe in your role:

```json
{
	"run_list": [
	"recipe[filezilla::default]"
	]
}
```

#### filezilla::server

Include the server recipe in your role to install the FileZilla server (Windows only):

```json
{
	"run_list": [
	"recipe[filezilla::server]"
	]
}
```

Authors
-----------------
- Author:: Lance Powell (lanceraymondpowell@gmail.com)

#### I adopted the Original FileZilla Cookbook
- Location:: https://github.com/Webtrends/Filezilla

```text
Copyright:: 2015, Lance Powell

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
