# chocolatey_source Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/chocolatey_source.svg)](https://supermarket.chef.io/cookbooks/chocolatey_source)

Provides a chocolatey_source resource for managing Chocolatey sources.

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

### chocolatey_source

#### Actions

- `:add` - Add a new Chocolatey source
- `:remove` - Remove an existing Chocolatey source

#### Properties

- `source_name` - Name property. The name of the source.
- `source` - the path to the source (filesystem or URL)
- `bypass_proxy` - should the system proxy be bypassed for this source (default: false)
- `priority` - the priority level for the source (default: 0)

#### Examples

Add a new source

```ruby
chocolatey_source 'my_corp_source' do
  source 'http://mycorp.dmz/choco_path/'
end
```

Using a descriptive resource name and providing the source with source_name property

```ruby
chocolatey_source 'Add my_corp Chocolatey Source' do
  source_name 'my_corp_source'
  source 'http://mycorp.dmz/choco_path/'
end
```

Removing a source

```ruby
chocolatey_source 'Add my_corp Chocolatey Source' do
  source_name 'my_corp_source'
  source 'http://mycorp.dmz/choco_path/'
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
