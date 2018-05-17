omsa Cookbook
=============
This cookbook installs Dell OpenManage Server Administrator repo including firmware-tools and srvadmin packages

Requirements
------------
#### cookbooks
- `yum` - omsa needs the yum cookbook to make use of the YumKey and YumRepo resources

#### packages
- `yum-dellsysid` - dell omsa repo makes use of the yum-dellsysid plugin.
- `dell_ft_install` - dell_ft_install installs everything dell needs to run firmware updates
- `srvadmin-all` - srvadmin-all installs OpenManage Server Administrator and its web interface.

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### omsa::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['omsa']['key']</tt></td>
    <td>String</td>
    <td>RPM GPG Key for OMSA</td>
    <td><tt>[url]</tt></td>
  </tr>
  <tr>
    <td><tt>['omsa']['indep']['includepkgs']</tt></td>
    <td>String</td>
    <td>Package list to include in repo</td>
    <td><tt>[comma separated package list]</tt></td>
  </tr>
  <tr>
    <td><tt>['omsa']['indep']['exclude']</tt></td>
    <td>String</td>
    <td>Package list to exclude from repo</td>
    <td><tt>[comma separated package list]</tt></td>
  </tr>
  <tr>
    <td><tt>['omsa']['indep']['mirrorlist']</tt></td>
    <td>String</td>
    <td>URL for mirrorlist for OMSA Independant repo</td>
    <td><tt>[url]</tt></td>
  </tr>
  <tr>
    <td><tt>['omsa']['specific']['includepkgs']</tt></td>
    <td>String</td>
    <td>Package list to include in repo</td>
    <td><tt>[comma separated package list]</tt></td>
  </tr>
  <tr>
    <td><tt>['omsa']['specific']['exclude']</tt></td>
    <td>String</td>
    <td>Package list to exclude from repo</td>
    <td><tt>[comma separated package list]</tt></td>
  </tr>
  <tr>
    <td><tt>['omsa']['specific']['mirrorlist']</tt></td>
    <td>String</td>
    <td>URL for mirrorlist for OMSA specific repo</td>
    <td><tt>[url]</tt></td>
  </tr>
</table>

Usage
-----
#### omsa::default

Just include `omsa::firmware` or `omsa::srvadmin` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[omsa::firmware]"
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
Authors: David Meiners
