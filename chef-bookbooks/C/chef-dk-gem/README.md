# chef-dk-gem
Resource cookbook to install or remove gems from a users chefdk gemset

Cookbook Dependencies
------------
- chef-dk

Usage
-----
Place a dependency on the chef-dk-gem cookbook in your cookbook's metadata.rb
```ruby
depends 'chef-dk-gem'
```

Then, in a recipe:

```ruby
chef_dk_gem 'foo' do
  user 'foo'
  version '1.0'
  action [:install]
end
```

License & Authors
-----------------
- Author:: Franklin Hanson (<fhanson@gannett.com>)

```text
Copyright:: 2015

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```