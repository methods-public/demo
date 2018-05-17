jolokia-jvm-agent Cookbook
==========================

This cookbook install [jolokia-jvm-agent](http://www.jolokia.org/download.html)

Install to `/opt/jolokia/jolokia-jvm-agent.jar`

Attributes
----------

#### jolokia-jvm-agent::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['jolokia-jvm-agent']['version]</tt></td>
    <td>String</td>
    <td>viersion number</td>
    <td><tt>1.2.3</tt></td>
  </tr>
  <tr>
    <td><tt>['jolokia-jvm-agent']['dir]</tt></td>
    <td>String</td>
    <td>Install directory</td>
    <td><tt>/opt/jolokia</tt></td>
  </tr>
</table>

Usage
-----
#### jolokia-jvm-agent::default

Just include `jolokia-jvm-agent` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[jolokia-jvm-agent]"
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
License: MIT
Authors: hirocaster
