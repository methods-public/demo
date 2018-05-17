# cpanel Cookbook

This cookbook is meant to manage and install cPanel (as automated as possible)
Currently not many features have been installed

## Requirements

e.g.
### Platforms

- CentOS
- RedHat
- CloudLinux

### Chef

- Chef 12.0 or later

### Cookbooks

| Cookbook     | Description |
|:-------------|:------------|
| default.rb   | Does nothing at all
| manage.rb    | installs all the applications (clamav, whmcs, packages,features) if enabled by attribute
| dns_only.rb  | Install dns_only cpanel without any configuration been touched

## Attributes


### cpanel::default

| Attribute | Default | Description|
|:----------|:--------|:-----------|
| `node['cpanel']['manage_features']['clamav']` | false | Executes the clamav installation/configuration
| `node['cpanel']['manage_features']['features']` | false | Manages Features (for packages)
| `node['cpanel']['manage_features']['packages']` | false | Manages Packages
| `node['cpanel']['manage_features']['whmcs']` | false | Copies a WHMCS page under /var/www/html for use with WHMCS

## Usage

### cpanel::default

TODO: Write usage instructions for each cookbook.

e.g.
Just include `cpanel` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cpanel::manage]"
  ]
}
```

## Contributing

1. Fork the repository on Gitlab
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors
|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | [Vassilis Aretakis](https://gitlab.com/billias) (<vassilis@aretakis.eu)




      Licensed under the Apache License, Version 2.0 (the "License");
      you may not use this file except in compliance with the License.
      You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      See the License for the specific language governing permissions and
      limitations under the License.
