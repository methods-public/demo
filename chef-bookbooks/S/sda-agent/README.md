sda-agent Cookbook
==================
This cookbook installs a Serena Deployment Automation Agent

Requirements
------------
#### packages
- `java` - sda-agent needs Java to install and run.

Attributes
----------
#### sda-agent::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sda-agent']['server_uri']</tt></td>
    <td>String</td>
    <td>The Serena DA Server from which to retrieve the Agent installer.</td>
    <td><tt>http://localhost:8080/serena_ra</tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['agent_name']</tt></td>
    <td>String</td>
    <td>The name of the agent.</td>
    <td><tt>The nodes FQDN</tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['agent_dir']</tt></td>
    <td>String</td>
    <td>The directory to install the agent to.</td>
    <td>Unix/Linux: <tt>/opt/serena_da/agent</tt><br/>
	    Windows: <tt>C:\Program Files\Serena\SDA Agent</tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['java_home']</tt></td>
    <td>String</td>
    <td>The Java HOME directory.</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['remote_host']</tt></td>
    <td>String</td>
    <td>The Serena DA Server hostname.</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['remote_port']</tt></td>
    <td>Integer</td>
    <td>The Serena DA Server JMS port.</td>
    <td><tt>7918</tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['proxy_host']</tt></td>
    <td>String</td>
    <td>The Serena DA Proxy Server hostname.</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['proxy_port']</tt></td>
    <td>Integer</td>
    <td>The Serena DA Proxy Server port.</td>
    <td><tt>20080</tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['mutual_auth']</tt></td>
    <td>Boolean</td>
    <td>Whether mutual authentication is to be configured between agent and server.
	Note: additional setup is required to configure this option (see manual).</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['user']</tt></td>
    <td>String</td>
    <td>The user which the Agent is be executed as.</td>
    <td>Unix/Linux: <tt>sda</tt><br/>
	Windows: <tt>HOSTNAME\sda</tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['group']</tt></td>
    <td>String</td>
    <td>The group which the Agent is to be executed as.</td>
    <td>Unix/Linux: <tt>sda</tt><br/>
	    Windows: <tt>HOSTNAME\sda</tt></td>
  </tr>
  <tr>
    <td><tt>['sda-agent']['reinstall']</tt></td>
    <td>Boolean</td>
    <td>Force reinstall of Agent (based on new attributes).</td>
    <td><tt>false</tt></td>
  </tr>
</table>

Usage
-----
#### sda-agent::default

Just include `sda-agent` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[sda-agent]"
  ]
}
```

Or better still create a role such as `base` which also resolve dependencies:

```json
{
  "name": "base",
  "description": "Baseline configuration for all systems.",
  "json_class": "Chef::Role",
  "default_attributes": {
    "java": {
      "install_flavor": "openjdk",
      "jdk_version": "6",
      "set_etc_environment": true
    }
  },
  "override_attributes": {
    "sda-agent": {
      "server_uri": "http://my_sda_server:8080/serena_ra",
      "java_home": "/usr/lib/jvm/java-6-openjdk-amd64",
      "remote_host": "my_sda_server",
      "remote_port": 7918
    }
  },
  "chef_type": "role",
  "run_list": [
    "recipe[java]",
    "recipe[sda-agent]"
  ],
  "env_run_lists": {

  }
}
```

Note: Linux support only at the moment.

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
Authors: Kevin Lee (klee@serena.com)
