[![Build Status](https://travis-ci.org/psyreactor/yum-pydio-cookbook.svg?branch=master)](https://travis-ci.org/psyreactor/yum-pydio-cookbook)

Yum Pydio Cookbook
===============

This cookbook Pydio repo Enterprise Linux.

####[Pydio Repo](http://www.pyd.io)
"The Pydio repo:

    To provide binary for pydio (ajaxExplorer) cloud system on-premise.
"

Requirements
------------
#### Cookbooks:

- yum - https://github.com/opscode-cookbooks/yum

The following platforms and versions are tested and supported using Opscode's test-kitchen.

- CentOS 5.8, 6.3

The following platform families are supported in the code, and are assumed to work based on the successful testing on CentOS.


- Red Hat (rhel)
- Fedora
- Amazon Linux

#### pydio:default
##### Basic Config
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>node['yum'][repo]['enabled']</tt></td>
    <td>Boolean</td>
    <td>Enable/Disable Repo</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>node['yum'][repo]['gpgcheck']</tt></td>
    <td>Boolean</td>
    <td>check GPG Cert</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>node['yum'][repo]['managed']</tt></td>
    <td>Boolean</td>
    <td>Enable/Disable managed</td>
    <td><tt>true</tt></td>
  </tr>
</table>

repo = w%(pydio pydio-testing pydio-sources)

Usage
-----
#### yum-pydio::default
Just include `yum-pydio` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yum-pydio]"
  ]
}
```

Example local copy if repocitory

```json
"default_attributes": {
  "yum": {
    "pydio-sources": {
      "repositoryid": "pydio-sources",
      "description": "Pydio 6 generic",
      "baseurl": "http://localip/repo/pydio-sources",
      "gpgcheck": true,
      "managed": true,
      "enabled": true
    }
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

[More details](https://github.com/psyreactor/yum-pydio-cookbook/blob/master/CONTRIBUTING.md)

License and Authors
-------------------
Authors:
Lucas Mariani (Psyreactor)
- [marianiluca@gmail.com](mailto:marianiluca@gmail.com)
- [https://github.com/psyreactor](https://github.com/psyreactor)
- [http://blog.psyreactor.com.ar](http://blog.psyreactor.com.ar)

