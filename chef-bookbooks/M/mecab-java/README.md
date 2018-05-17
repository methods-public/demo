mecab-java Chef Cookbook
=======================

[![Circle CI](https://circleci.com/gh/kogecoo/chef-mecab-java.svg?style=svg)](https://circleci.com/gh/kogecoo/chef-mecab-java)

 Installs an official java binding for mecab

Platforms
---------
The following platforms and versions are tested and supported using test-kitchen
* Ubuntu 14.04
* Debian 7.8
* CentOS 7.0

Attributes
-----
IMPORTANT!
* You need to set the path where mecab-java binding will be installed to `node['mecab-java']['install_to']`

see also [source](attributes/default.rb)

Usage
-----
Just include `mecab-java` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mecab-java]"
  ]
}
```

Misc
----
[GitHub Repository](http://github.com/kogecoo/chef-mecab-java)

License and Author
-------------------
- Author: [kogecoo](http://github.com/kogecoo)
- License: Apache License, Version 2.0 (see [LICENSE](LICENSE))
