c-icap Cookbook
==============
This cookbook installs c-icap software

Requirements
------------
### Supported Operating Systems
- Debian-family Linux Distributions
- RedHat-family Linux Distributions

### Cookbooks
- Depends on `checkinstall` cookbook
- When running on Rhel based systems, the node must include the `yum-epel` cookbook

Attributes
----------
### Recommended tunables

* `c_icap['install_method']`
  - String. Defaults to `source`. Can be `source` or `package`
  - `source` downloads source codes and compile them, then executes checkinstall to install as package
  - `package` installs package from the existing repo via apt or yum, depending on the distribution

* `c_icap['url']`
  - String. Points to the c-icap source codes archive location

* `c_icap['version']`
  - String. c-icap version to be compiled

* `c_icap['checksum']`
  - String. Source codes archive checksum

* `c_icap_modules['url']`
  - String. Points to the c-icap-modules source codes archive location

* `c_icap_modules['version']`
  - String. c-icap-modules version to be compiled

* `c_icap_modules['checksum']`
  - String. Source codes archive checksum

* `c_icap['port']`
  - String. Port for c-icap to listen
  - Defaults to `1344`

### Source specific

* `c-icap['prefix_dir']`
  - String. The path to prefix dir
  - Defaults to `/`

* `c-icap['exec_prefix_dir']`
  - String. The path to exec_prefix dir
  - Defaults to `/usr`

* `c-icap['config_dir']`
  - String. The path to configuration file dir
  - Defaults to `/etc/c-icap`

* `c-icap['doc_dir']`
  - String. The path to docs dir
  - Defaults to `/usr/share`

Usage
-----
#### c-icap::default
Just include `c-icap` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[c-icap]"
  ]
}
```

License and Authors
-------------------

- Author:: Rostyslav Fridman (rostyslav.fridman@gmail.com)

```text
Copyright 2014, Rostyslav Fridman

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
