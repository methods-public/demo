[![Build Status](https://secure.travis-ci.org/daptiv/vmware_workstation.png)](http://travis-ci.org/daptiv/vmware_workstation)

vmware_workstation Cookbook
===========================
Installs and configures VMware Workstation 10

Requirements
------------
#### Platforms

* `Ubuntu` - 64-bit.
* `Windows` - 32-bit and 64-bit.

#### Cookbooks

* `windows` - required to use the windows_package resource that installs on the Windows platform.

Attributes
----------

#### vmware_workstation::ubuntu
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['accept_eula']</tt></td>
    <td>Boolean</td>
    <td>whether to accept the end user license agreement</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['serial_number']</tt></td>
    <td>String</td>
    <td>the product serial number</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['source_prefix']</tt></td>
    <td>String</td>
    <td>the uri of the source (do <u>not</u> include a trailing slash)</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['install_file']</tt></td>
    <td>String</td>
    <td>the name of the installer file</td>
    <td><tt>VMware-Workstation-Full-10.0.2-1744117.x86_64.bundle</tt></td>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['checksum']</tt></td>
    <td>String</td>
    <td>the SHA1SUM checksum</td>
    <td><tt>f32b72ecfc8b808731e97c3d478a1cda78427aaf</tt></td>
  </tr>
</table>

#### vmware_workstation::windows
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['accept_eula']</tt></td>
    <td>Boolean</td>
    <td>whether to accept the end user license agreement</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['serial_number']</tt></td>
    <td>String</td>
    <td>the product serial number</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['source_prefix']</tt></td>
    <td>String</td>
    <td>the uri of the source (do <u>not</u> include a trailing slash)</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['install_file']</tt></td>
    <td>String</td>
    <td>the name of the installer file</td>
    <td><tt>VMware-workstation-full-10.0.2-1744117.exe</tt></td>
  </tr>
  <tr>
    <td><tt>['vmware_workstation']['checksum']</tt></td>
    <td>String</td>
    <td>the SHA1SUM checksum</td>
    <td><tt>f7826612ceccadf2f6b09b24305c16c32865e48e</tt></td>
  </tr>
</table>

Usage
-----
#### vmware_workstation::default

Just include `vmware_workstation` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[vmware_workstation]"
  ]
}
```

#### vmware_workstation::ubuntu

Include `vmware_workstation::ubuntu` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[vmware_workstation::ubuntu]"
  ]
}
```

#### vmware_workstation::windows

Include `vmware_workstation::windows` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[vmware_workstation::windows]"
  ]
}
```

Testing this cookbook
---------------------
This cookbook uses [chefspec](https://github.com/sethvargo/chefspec) and [test-kitchen](https://github.com/opscode/test-kitchen)
along with [kitchen-vagrant](https://github.com/opscode/kitchen-vagrant).  Update the Vagrantfile and .kitchen.yml files wherever it has 'REPLACE_ME'.

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
   - test-kitchen (minitest)
   - chef-spec
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: dl_teamengineering@daptiv.com
