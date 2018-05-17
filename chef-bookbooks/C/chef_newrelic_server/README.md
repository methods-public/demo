chef_newrelic_server Cookbook
=============================

This cookbook install NewRelic server monitoring for you. It supports centos, redhat, debian and ubuntu.

Requirements
------------

None.

Attributes
----------

#### chef_newrelic_server::default
|    Key     |   Type    | Description | Default |
|------------|-----------|-------------|---------|
|['newrelic_server']['license_key']|String|Newrelic license key (it has to be 40 characeters)|15bku035alsc55k263e507d39c45e91c20318103|

Usage
-----
#### chef_newrelic_server::default

Just include `chef_newrelic_server` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef_newrelic_server]"
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
Authors: [ Faizal F Zakaria ]
