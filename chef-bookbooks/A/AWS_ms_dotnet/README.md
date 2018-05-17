AWS_ms_dotnet Cookbook
=================================
This cookbooks downloads/installs the Amazon Web Services (AWS) .Net tools kit on Windows.


Requirements
------------
This cookbook supports Chef 11.14.2


#### Platforms
* Windows 2012 R2


Attributes
----------
* `node['AWS_ms_dotnet']['source'] - the source of where to download the MSI package from Amazon if it ever changes.
* `node['AWS_ms_dotnet']['package_regkey'] - used checking if the package is already installed.

Usage
-----
This cookbook works out of the box. Just include `AWS_ms_dotnet` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[AWS_ms_dotnet]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
* Authors: Yeung Siu (yeung.siu@citrix.com)

Copyright:: 2015 Citrix Systems, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.