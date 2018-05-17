# netdevops-cookbook

[![Build Status](https://travis-ci.org/netdevops/netdevops-cookbook.svg?branch=master)](https://travis-ci.org/netdevops/netdevops-cookbook)

`netdevops` transforms a Linux system into a [NetDevOps](https://github.com/netdevops/netdevops) environment

## Supported Platforms

 - Ubuntu 14.04.2 LTS
 - CentOS 6.5+ / RHEL 6.5+ tested
 - CentOS 7.x / RHEL 7.x tested
 - Should work with minimal effort on most modern Debian-based platforms (Intel 64-bit-only)

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['netdevops']['default']</tt></td>
    <td>Boolean</td>
    <td>whether to include build</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['netdevops']['opencontrail']</tt></td>
    <td>Boolean</td>
    <td>whether to include contrail vnc_api</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['netdevops']['desktop']</tt></td>
    <td>Boolean</td>
    <td>whether to include Gnome graphical desktop</td>
    <td><tt>false</tt></td>
  </tr>
</table>

## Usage

### netdevops::default

Include `netdevops` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[netdevops::default]"
  ]
}
```

## License and Authors

Author:: John Deatherage(<john@routeoflastresort.com>)
