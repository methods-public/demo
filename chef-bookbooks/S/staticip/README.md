staticip Cookbook
================
Configure static ip

Requirements
------------
### Platform
- Debian/Ubuntu
- RHEL/CentOS/Scientific
- Fedora
- ArchLinux
- FreeBSD

Recipes
-------
* default

Attributes List
---------------

* `node['staticip']['nic_interface]` - Which nic interface to configure ip. Default value is eth0
* `node['staticip']['ipaddress']` - What ip it should configure

Examples and Common usage
-------------------------
# Configure eth0 as 192.168.1.103
```json
"staticip": {
  "nic_interface": "eth0",
  "ipaddress": "127.0.0.1"
}
```

License & Authors
-----------------
- Author:: DennyZhang001 <denny.zhang001@gmail.com>
- Copyright:: 2015, http://DennyZhang.com

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
