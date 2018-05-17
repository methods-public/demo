opt-python Cookbook
===============
This cookbook installs python from source as an optional software package. 
The default path is `/opt/python-<version>`, so that it avoid mixing it up
with your system's python package.

Requirements
------------

#### platforms
- CentOS 6.5 is supported and tested.

Attributes
----------
#### opt-python::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opt-python']['version']</tt></td>
    <td>Text</td>
    <td>Python version</td>
    <td><tt>2.7.8</tt></td>
  </tr>
  <tr>
    <td><tt>['opt-python']['install_dir']</tt></td>
    <td>Text</td>
    <td>Directory to install</td>
    <td><tt>/opt</tt></td>
  </tr>
  <tr>
    <td><tt>['opt-python']['download_dir']</tt></td>
    <td>Text</td>
    <td>Directory to download source code</td>
    <td><tt>/tmp</tt></td>
  </tr>
</table>

Usage
-----
#### opt-python::default
Just include `opt-python` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opt-python]"
  ]
}
```

#### opt-python::modulefile
If you have [Environment Modules](http://modules.sourceforge.net/) on your machine, include `opt-python::modulefile` in your node's `run_list` and set attrubutes, `modulefile_dir` and `default_version`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opt-python::modulefile]"
  ],
  "opt-python": {
    "modulefiles_dir": "/opt/module-3.2.10/Module/3.2.10/modulefile/tools",
    "default_version": "2.7.8"
  }
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
Copyright 2014, FutureGrid, Indiana Univercity

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
