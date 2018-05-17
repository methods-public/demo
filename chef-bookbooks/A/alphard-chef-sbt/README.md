[![Cookbook Version](https://img.shields.io/cookbook/v/alphard-chef-sbt.svg)](https://supermarket.chef.io/cookbooks/alphard-chef-sbt)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Build Status](https://travis-ci.org/hydra-technologies/alphard-chef-sbt.svg?branch=master)](https://travis-ci.org/hydra-technologies/alphard-chef-sbt)
[![Coverage Status](https://coveralls.io/repos/github/hydra-technologies/alphard-chef-sbt/badge.svg?branch=master)](https://coveralls.io/github/hydra-technologies/alphard-chef-sbt?branch=master)

# Chef SBT Cookbook

This cookbook installs SBT (http://www.scala-sbt.org/).

## Requirements

### Platforms

- Ubuntu 14.04
- Ubuntu 16.04
- CentOS 6
- CentOS 7
- Fedora
- Debian 8

### Chef

- Chef 12.0 or later

### Cookbooks

- `java` - Java is needed to launch sbt. It sets the default java version to 8.

## Attributes

### alphard-chef-sbt::default

- `['alphard-chef-sbt']['user']` - The user used to create files, directories and execute commands.
- `['alphard-chef-sbt']['group']` - The group used to create files, directories and execute commands.
- `['alphard-chef-sbt']['home']` - The SBT home location.
- `['alphard-chef-sbt']['version']` - The SBT version.

## Usage

### alphard-chef-sbt::default

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[alphard-chef-sbt]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License

Copyright 2009-2016, Hydra Technologies, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Authors

- Frédéric Nowak - frederic.nowak@hydra-technologies.net
