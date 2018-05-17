[![Build Status](https://travis-ci.org/psyreactor/yum-jpackage-cookbook.svg?branch=master)](https://travis-ci.org/psyreactor/yum-jpackage-cookbook)

Yum JPackage Cookbook
===============

This cookbook jpackage repo Enterprise Linux.

####[JPackage Repo](http://www.jpackage.org)
"The JPackage Project has two primary goals:

    To provide a coherent set of Java software packages for Linux, satisfying all quality requirements of other applications.
    To establish an efficient and robust policy for Java software packaging and installation.

We focus on free and open source software whenever possible. For convenience, we also provide non-free packages without the restricted source code. "

Requirements
------------
#### Cookbooks:

- yum - https://github.com/opscode-cookbooks/yum

The following platforms and versions are tested and supported using Opscode's test-kitchen.

- CentOS 6.x 
- Red Hat 6.x

The following platform families are supported in the code, and are assumed to work based on the successful testing on CentOS.

- Amazon Linux

#### jpackage:default
##### Basic Config
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>node[:yum][:jpackage][:managed]</tt></td>
    <td>Boolean</td>
    <td>Instal Repo</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>node[:yum][:jpackage][:enabled]</tt></td>
    <td>Boolean</td>
    <td>Enable/Disable Repo</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>node[:yum][:jpackage][:gpgcheck]</tt></td>
    <td>Boolean</td>
    <td>check GPG Cert</td>
    <td><tt>false</tt></td>
  </tr>
</table>


Usage
-----
#### yum-jpackage::default
Just include `yum-jpackage` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yum-jpackage]"
  ]
}
```

Example local copy if repocitory

```json
"default_attributes": {
  "yum": {
    "jpackage": {
      "repositoryid": "jpackage",
      "description": "JPackage 6 generic",
      "baseurl": "http://localip/repo/jpackage",
      "gpgcheck": false,
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

[More details](https://github.com/psyreactor/yum-jpackage-cookbook/blob/master/CONTRIBUTING.md)

License and Authors
-------------------
Authors:
Lucas Mariani (Psyreactor)
- [marianiluca@gmail.com](mailto:marianiluca@gmail.com)
- [https://github.com/psyreactor](https://github.com/psyreactor)
- [http://blog.psyreactor.com.ar](http://blog.psyreactor.com.ar)

