simple_iptables_ng Cookbook
===========================
A simple wrapper book to easily manage iptables. supports also deleting rules
from previous chef runs.

Requirements
------------
### Platforms
- Debian, Ubuntu
- CentOS 6+, Red Hat 6+, Fedora, Amazon

Attributes
----------
 * `node['simple_iptables_ng']['data_bags']` - data bags to load for iptables rules
 * `node['simple_iptables_ng']['max_rules']` - maximum rules to support used for
   deleting rules from previous runs

Usage
-----
#### simple_iptables_ng::default
Include `simple_iptables_ng` in your node's `run_list` or role's `run_list`:

```json
{
  "run_list": [
    "recipe[simple_iptables_ng]"
  ],
  "simple_iptables_ng": {
    "entries": [
      {
        "comment": "test comment",
        "rules": [
          { "from_addr": "10.0.0.1/32", "start_port": 22 }
        ]
      },
      { "data_bag": "http" }
    ]
  }
}
```

A data bag of rules looks similar to:
```
{
  "id": "http",
  "entries": [
      {
          "comment": "http and https rules",
          "rules": [
              { "from_addr": "0.0.0.0/0", "start_port": 80 },
              { "from_addr": "0.0.0.0/0", "start_port": 443 }
          ]
      }
  ]
}
```

The recipe supports both rules in the node definition and in data bags.

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
Authors:: Dan Fruehauf

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
