# newrelic-sysmond-policy

Cookbook containing a start/stop script to associate the server with a particular server policy at startup and possibly another one at shutdown (for cloud "spot" or "autoscale" VMs)

## Supported Platforms

- CentOS 5.6
- Ubuntu 14.04

It probably works on any other platform that uses init-style startup/shutdown scripts

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>[:newrelic_sysmond_policy][:installprereqs]</tt></td>
    <td>Boolean</td>
    <td>whether to install prerequisites (node.js, npm, newrelic-sysmond-policy package) via the nodejs cookbook (if false, make sure that newrelic-sysmond-policy is installed and on your path) </td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>[:newrelic_sysmond_policy][:path]</tt></td>
    <td>String</td>
    <td>Path to newrelic-sysmond-policy (important if you are installing the prerequisites on your own) </td>
    <td><tt>/usr/bin/newrelic-sysmond-policy</tt></td>
  </tr>
  <tr>
    <td><tt>[:newrelic][:apikey]</tt></td>
    <td>String</td>
    <td>NewRelic API Key. Must be set. [Read more](https://docs.newrelic.com/docs/apm/apis/requirements/api-key#creating)</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>[:newrelic][:server_monitoring][:startup_policy]</tt></td>
    <td>String</td>
    <td>Policy to assign at startup</td>
    <td><tt>Default server alert policy</tt></td>
  </tr>
  <tr>
    <td><tt>[:newrelic][:server_monitoring][:shutdown_policy]</tt></td>
    <td>String</td>
    <td>Policy to assign at shutdown.  By default this will take whatever is configured as the startup policy, effectively leaving the server in the same policy at shutdown.  In a dynamically provisioned environment, however, you may want to set the shutdown environment to something useful to distiguish between servers which are not reporting and servers which were intentionally deprovisioned</td>
    <td><tt>Takes value from [:newrelic][:server_monitoring][:startup_policy]</tt></td>
  </tr>
</table>

## Usage

### newrelic-sysmond-policy::default

Include `newrelic-sysmond-policy` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[newrelic-sysmond-policy::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Issac Goldstand
