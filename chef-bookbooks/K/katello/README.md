# Katello Chef Cookbook

[![Build Status](https://travis-ci.org/juliandunn/katello.svg?branch=master)](https://travis-ci.org/juliandunn/katello)

This cookbook configures a system to be a [Katello](http://www.katello.org/) server.

Haven't heard of Katello? If you know [Spacewalk](http://spacewalk.redhat.com/) -- Katello
is the next version of that, and will eventually also become the next major version of
[RedHat Satellite Server](http://www.redhat.com/products/enterprise-linux/satellite/).

## Supported Platforms

* Fedora 19+
* CentOS 6+
* RedHat 6+

## Usage

### katello::default

Include `katello` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[katello::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass. This cookbook is also continuously tested with [Travis](http://travis-ci.org/juliandunn/katello).
6. Submit a pull request.

## License and Authors

* Author:: Julian C. Dunn (<jdunn@getchef.com>)

```text
Copyright:: 2014, Chef Software, Inc.

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
