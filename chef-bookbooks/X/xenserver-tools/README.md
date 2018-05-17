XenServer Tools Cookbook
========================
Installs the XenServer Tools packages provided by Citrix.

Requirements
------------
This cookbook has been tested on:

- CentOS 7
- Debian 8
- Chef 12.16

Usage
-----
#### xenserver-tools::default
Installs the appropriate packages for the OS and starts the xe-linux-distribution service.

Contributing
------------
You know what to do. ;)

License and Authors
-------------------
- Author:: James Le Cuirot (<james.le-cuirot@yakara.com>)

```text
# Copyright (C) 2016 Yakara Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
```

The packages found in the files directory are verbatim copies of those found on the guest tools ISO bundled with XenServer. I could not find them elsewhere. They are BSD licensed and therefore safe to redistribute.
