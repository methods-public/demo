# Appium Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/appium.svg?style=flat-square)][supermarket]
[![Build Status](http://img.shields.io/travis/dhoer/chef-appium.svg?style=flat-square)][travis]
[![GitHub Issues](http://img.shields.io/github/issues/dhoer/chef-appium.svg?style=flat-square)][github]

[supermarket]: https://supermarket.chef.io/cookbooks/appium
[travis]: https://travis-ci.org/dhoer/chef-appium
[github]: https://github.com/dhoer/chef-appium/issues

This cookbook installs Appium (http://appium.io/).

## Requirements

- Chef 11 or higher
- XCode 4.5 or higher w/ Command Line Tools

### Platforms

- CentOS, RedHat
- Mac OS X
- Ubuntu

### Cookbooks

- nodejs 

## Usage

Add the cookbook to your run_list in a node or role:

```ruby
"run_list": [
  "recipe[appium::default]"
]
```

or include it in a recipe:

```ruby
depends 'appium'
```

```ruby
include_recipe 'appium::default'
```

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-appium).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-appium/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-appium/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-appium/blob/master/LICENSE.md) file for details.
