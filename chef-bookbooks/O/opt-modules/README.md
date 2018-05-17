opt-modules Cookbook
============================
This cookbook installs [Environment Modules](http://modules.sourceforge.net/).

Requirements
------------

#### cookbooks
- `apt`
- `build-essential`

#### platforms
- Ubuntu 12.04 and CentOS 6.5 are supported and tested.

Attributes
----------

#### default
* `['modules']['version']` - Version of Environment Modules. Default is `3.2.10`.
* `['modules']['download_url']` - Download URL. Default is http://prdownloads.sourceforge.net/modules/modules-['modules']['version'].tar.gz
* `['modules']['download_dir']` - Download directory. Default is `/tmp`.
* `['modules']['install_dir']` - Install directory. Default is `/opt`.

Usage
-----
#### environment-modules::default

Include `opt-modules` in your node's `run_list` as shown below.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opt-modules]"
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
- Author:: Koji Tanaka (<kj.tanaka@gmail.com>)

```text
Copyright:: 2014 FutureGrid Project, Indiana University

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
