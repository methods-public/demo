mecab-ruby Chef Cookbook
=======================

[![Circle CI](https://circleci.com/gh/kogecoo/chef-mecab-ruby.svg?style=svg)](https://circleci.com/gh/kogecoo/chef-mecab-ruby)

Installs an official ruby binding for mecab

Requirements
---------
* ruby >= 1.9

Platforms
---------
The following platforms and versions are tested and supported using test-kitchen
* Ubuntu 14.04
* CentOS 7.0

Attributes
-----
see [source](attributes/default.rb)

Usage
-----
Just include `mecab-ruby` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mecab-ruby]"
  ]
}
```

Misc
----
[GitHub Repository](http://github.com/kogecoo/chef-mecab-ruby)

License and Author
-------------------
- Author: [kogecoo](http://github.com/kogecoo)
- License: Apache License, Version 2.0 (see [LICENSE](LICENSE))
