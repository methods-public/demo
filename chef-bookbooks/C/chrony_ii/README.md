chrony_ii cookbook
==================

[![Build Status](https://travis-ci.org/elastic-infra/chrony_ii.svg?branch=master)](https://travis-ci.org/elastic-infra/chrony_ii) [![GitHub license](https://img.shields.io/github/license/elastic-infra/chrony_ii.svg)](https://github.com/elastic-infra/chrony_ii/blob/master/LICENSE) [![GitHub issues](https://img.shields.io/github/issues/elastic-infra/chrony_ii.svg)](https://github.com/elastic-infra/chrony_ii/issues)

This cookbook installs chrony.

Requirements
------------

#### platforms
- debian >= 8
  - debian7 should work but the installed version (v1.24) is too old to run on Linux 4.x (for CI)
- ubuntu >= 16.04
- centos >= 6
- redhat
- amazon

Attributes
----------

#### chrony_ii::config

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['chrony_ii']['config']</tt></td>
    <td>Hash</td>
    <td>chrony.conf value. Hash value can be a string or an array of string.</td>
    <td><tt>Depends on platform (see `attributes/default.rb`)</tt></td>
  </tr>
  <tr>
    <td><tt>['chrony_ii']['amazon_time_sync_service']</tt></td>
    <td>Boolean</td>
    <td>Whether to use <a href="https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html#configure-amazon-time-service">Amazon Time Sync Service</a></td>
    <td>false</td>
  </tr>
  <tr>
    <td><tt>['chrony_ii']['config_update_restart']</tt></td>
    <td>Boolean</td>
    <td>Whether to restart chrony daemon after config file change</td>
    <td>true</td>
  </tr>
</table>

Usage
-----
#### chrony_ii::default

Just include `chrony_ii` in your node's `run_list`:
```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chrony_ii]"
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
Authors: Tomoya Kabe
