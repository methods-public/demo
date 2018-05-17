# chocolatey_config Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/chocolatey_config.svg)](https://supermarket.chef.io/cookbooks/chocolatey_config)

Provides a chocolatey_config resource for managing Chocolatey configs.

## Requirements

### Platforms

- Windows 7
- Windows Server 2008 R2
- Windows 8, 8.1
- Windows Server 2012 (R1, R2)
- Windows Server 2016

### Chef

- Chef 13+

## Resources

### chocolatey_config

#### Actions

- `:set` - Sets a Chocolatey config
- `:unset` - Unsets a Chocolatey config

#### Properties

- `config_key` - Name property. The name of the config.
- `value` - the value to set (required for :set action)

#### Examples

Add a new config

```ruby
chocolatey_config 'cacheLocation' do
  value 'c:\temp\choco'
end
```

Using a descriptive resource name and providing the config with config_key property

```ruby
chocolatey_config 'Set the Chocolatey config path' do
  config_key 'cacheLocation'
  value 'c:\temp\choco'
end
```

Unset a config

```ruby
chocolatey_config 'cacheLocation' do
  action :unset
end
```

## License & Authors

- Author:: Tim Smith([tsmith@chef.io](mailto:tsmith@chef.io))

```text
Copyright 2018, Chef Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
`
```
