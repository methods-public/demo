[![Cookbook Version](https://img.shields.io/cookbook/v/alphard-chef-awscli.svg)](https://supermarket.chef.io/cookbooks/alphard-chef-awscli)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Build Status](https://travis-ci.org/hydra-technologies/alphard-chef-awscli.svg?branch=master)](https://travis-ci.org/hydra-technologies/alphard-chef-awscli)
[![Coverage Status](https://coveralls.io/repos/github/hydra-technologies/alphard-chef-awscli/badge.svg?branch=master)](https://coveralls.io/github/hydra-technologies/alphard-chef-awscli?branch=master)

# Cookbook 'alphard-chef-awscli'

The cookbook installs awscli command line tool (https://aws.amazon.com/fr/cli/).

## Requirements

### Platforms

- Ubuntu 12.04 (not tested)
- Ubuntu 14.04 (not tested)
- Ubuntu 16.04 (not tested)
- CentOS 6 
- CentOS 7
- Fedora (not tested)
- Debian 8

### Chef

- Chef 12.5 or later

### Cookbooks

- `poise-python` - alphard-chef-awscli needs poise python to install pip.

## Attributes

- `default['alphard']['awscli']['user']`= The user used to install awscli and create configuration file.
- `default['alphard']['awscli']['group']` = The group used to install awscli and create configuration file.
- `default['alphard']['awscli']['configuration_directory']` = The awscli configuration file installation path.
- `default['alphard']['awscli']['access_key']`  = The AWS access key (Optional)
- `default['alphard']['awscli']['secret_key']` = The AWS secret key (Optional)
- `default['alphard']['awscli']['version']` = The awscli version.
- `default['alphard']['awscli']['configuration_file']` = The awscli configuration file path.

## Usage

### alphard-chef-awscli::default

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[alphard-chef-awscli]"
  ]
}
```

Once the recipe installed, you can use the resource awscli and pass arguments as you would pass arguments to the 
aws tool in a bash session.

```
awscli 's3 ls s3://mybucket'
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License

Copyright 2009-2017, Hydra Technologies, Inc

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
