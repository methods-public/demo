# pertino-cookbook

[![Cookbook](http://img.shields.io/cookbook/v/pertino.svg)](https://supermarket.chef.io/cookbooks/pertino)
[![CircleCI](https://img.shields.io/circleci/project/miketheman/pertino-cookbook.svg)](https://circleci.com/gh/miketheman/pertino-cookbook)
[![Coverage Status](https://coveralls.io/repos/miketheman/pertino-cookbook/badge.svg?branch=master)](https://coveralls.io/r/miketheman/pertino-cookbook?branch=master)
[![GitHub issues](https://img.shields.io/github/issues/miketheman/pertino-cookbook.svg)](https://github.com/miketheman/pertino-cookbook/issues)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/miketheman/pertino-cookbook/master/LICENSE)

This cookbook exposes a resource to set up a connection to the [Pertino](http://pertino.com/) network.

## Tested

- Ubuntu 14.04
- Ubuntu 12.04
- CentOS 6.6

- Chef 11.18.12, 12.0.3

See [TESTING.md](TESTING.md) for more.

## Usage

Add `depends 'pertino'` to your application cookbook's `metadata.rb`.

In a recipe, create a `pertino_client` resource and provide it with authentication
details:

```ruby
# UserPass Auth
pertino_client 'default' do
  auth_mode 'userpass'
  username 'my_pertino_username'
  password 'my_super_secret_password'
end

# Device Auth
pertino_client 'default' do
  auth_mode 'api_key'
  api_key 'key_source' # could be from a databag, attribute, etc.
end
```

Note: The resource name `default` isn't used.

See [`test/fixtures/cookbooks`](test/fixtures/cookbooks) for some more examples.

Recommended: Pair with a [`logrotate_app` resource](https://github.com/stevendanna/logrotate#usage)
to ensure that the log files do not grow beyond manageable.

## License and Authors

Author:: Mike Fiedler (<miketheman@gmail.com>)

See LICENSE for details.
