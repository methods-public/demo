# flyway-cookbook
[![Cookbook](http://img.shields.io/cookbook/v/flyway.svg)](https://github.com/base2Services/flyway_cookbook)
[![Build Status](https://travis-ci.org/base2Services/flyway_cookbook.svg?branch=master)](https://travis-ci.org/base2Services/flyway_cookbook)

Install and configures [flywaydb](http://flywaydb.org) and allows for execution
of database migrations

## Supported Platforms

 * Centos, RedHat & Amazon Linux
 * Ubuntu, debian
 * Windows

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['flyway']['version']</tt></td>
    <td>String</td>
    <td>the version of fly to install</td>
    <td><tt>3.2.1</tt></td>
  </tr>
  <tr>
    <td><tt>['flyway']['install_dir']</tt></td>
    <td>String</td>
    <td>the base install directory</td>
<td><tt><ul><li>linux /opt</li><li>windows C:\</li></tt></td>
  </tr>
  <tr>
    <td><tt>['flyway']['user']</tt></td>
    <td>String</td>
    <td>the owner of the flyway install</td>
    <td><tt>flyway</tt></td>
  </tr>
  <tr>
    <td><tt>['flyway']['group']</tt></td>
    <td>String</td>
    <td>the group of the flyway install</td>
    <td><tt>flyway</tt></td>
  </tr>
  <tr>
    <td><tt>['flyway']['conf']</tt></td>
    <td>Hash</td>
    <td>A hash used to create the default configuration for the flyway.conf file key values automatically get prefixed with flyway. example:
<pre>{
  url: 'jdbc:mysql/localhost/mydb',
  user: 'root',
  password: 'changeme'
  locations: 'filesystem:/myapp/db_migrations'
}</pre></td>
    <td><tt>{}</tt></td>
  </tr>
</table>

## Usage

### flyway::default

Include `flyway` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[flyway::default]"
  ],
  "flyway": {
    "version": "3.2.1",
    "install_dir":"/usr/local",
    "conf": {
      "url": "jdbc:mysql/localhost/mydb",
      "user": "root",
      "password": "changeme",
      "locations": "filesystem:/myapp/db_migrations"
    }
  }
}
```

## License and Authors
License:: Apache License, Version 2.0

Authors::
 * Aaron Walker - base2Services
