appveyor Cookbook
=================
This cookbook installs and configures AppVeyor and it's agent on a node.

Requirements
------------
Version 0.4.0+ of this cookbook requires Chef 11.4.4+.

#### Platforms

- Windows Server 2012
- Windows Server 2012 R2

#### packages
- `windows` - needed to administrate tasks on windows.

Attributes
----------
#### appveyor::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['appveyor']['agent']['access_key']</tt></td>
    <td>String</td>
    <td>Environment access key for the agent.</td>
    <td><tt>'CHANGE_ME'</tt></td>
  </tr>
  <tr>
    <td><tt>['appveyor']['agent']['location']</tt></td>
    <td>String</td>
    <td>Location of the AppVeyor agent.</td>
    <td><tt>C:\Program Files (x86)\AppVeyor\DeploymentAgent\Appveyor.DeploymentAgent.Service.exe</tt></td>
  </tr>
  <tr>
    <td><tt>['appveyor']['agent']['source']</tt></td>
    <td>String</td>
    <td>The source location to get the AppVeyor agent install from.</td>
    <td><tt>http://appveyor-ftp.azurewebsites.net/AppveyorDeploymentAgent.msi</tt></td>
  </tr>
  <tr>
    <td><tt>['appveyor']['agent']['deployment_group']</tt></td>
    <td>String</td>
    <td>The deployment group to add the agent to.</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

Usage
-----
#### appveyor::default
1. Include `appveyor` in your node's `run_list`:

  ```json
  {
    "name":"my_node",
    "run_list": [
      "recipe[appveyor]"
    ],
    "appveyor": {
      "agent": {
        "access_key": "Some access key",
        "deployment_group": "Group 1"
      }
    }
  }

License and Authors
-------------------

Author:: James Toyer. (<jamestoyer@toyertechnologies.com>)
