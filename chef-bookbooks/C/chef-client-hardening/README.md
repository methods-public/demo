# chef-client-hardening Cookbook | [![Cookbook Version](https://img.shields.io/cookbook/v/chef-client-hardening.svg)](https://community.opscode.com/cookbooks/chef-client-hardening) [![Build Status](https://travis-ci.org/sliim-cookbooks/chef-client-hardening.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/chef-client-hardening) 

Set correct owner/permissions for chef-client sensitive files

## Requirements

#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen:
- `Ubuntu 12.04`
- `Ubuntu 14.04`
- `Debian 7`
- `Debian 8`
- `Centos 6`
- `Centos 7`
- `Fedora 21`
- `Fedora 22`

## Usage

#### chef-client-hardening::default

This recipe will set owner & group to `root` for `/etc/chef/` and `/var/chef` directories and their sub directories/files.

Directories permissions are set to `0700` and files to `0600`.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-client-hardening]"
  ]
}
```

## Testing

You can use `rake` to invoke testing tasks (See `Rakefile` for details):

##### Checkstyle
```
$ rake test:checkstyle
```

Will run `foodcritic` and `cookstyle`.

##### Chefspec
```
$ rake test:chefspec
```

Will run unit tests with `ChefSpec`.

##### Kitchen
```
$ rake test:kitchen
```

Will test all kitchen instances declared in `.kitchen.yml`.

Docker driver is used for integration testing with `test-kitchen`. You will need to have `docker` installed to run integration testing, or adapt the existing `.kitchen.yml` for your driver.

```
$ kitchen list
$ kitchen test [instance]
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: Sliim <sliim@mailoo.org>

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

