# dkron chef cookbook

Dkron (http://dkron.io/) is a distributed cron system. This cookbook can be
used to setup a Dkron server or agent.

## Dependencies
  * ark
  * runit

## Recipes

Only a default recipe is provided. It installs dkron, sets up a service and
creates a config file. To control, whether the node will be a server or just
an agent, use the `node['dkron']['config']['server']` attribute.

The recipe does not handle the setup of the key value store for dkron. You
can do that in your role or wrapper recipe. Supported backend stores are
Etcd, Consul and Zookeeper. Default is Etcd.  

## Attributes

See `atributes/default.rb`.

## Testing
A test suite is available using rubocop, foodcritic and kitchen. To run static
analysis tests, issue
```
bundle exec rake test:quick
```

To run full suite including kitchen tests, issue
```
bundle exec rake test:complete
```

### Tested platforms
* CentOS 7.3
* Ubuntu 16.04

## License and Authors

Copyright 2016 Internet Mall, a.s.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

Authors:
- Michal Taborsky <michal.taborsky@mall.cz>
