MeCab Chef Cookbook
=======================

[![Circle CI](https://circleci.com/gh/kogecoo/chef-mecab.svg?style=svg)](https://circleci.com/gh/kogecoo/chef-mecab)

Installs MeCab, its program language bindings, and its well-known dictionary.


 Currently installing MeCab with Cef has some difficulty:

* MeCab binary is hosted at Google Drive.
* MeCab source hosted at GitHub is huge.

This recipe is implemented in a somewhat forcible manner, so there are some problems remains:
* It takes long running time because it checks out huge git repository of MeCab from github.
* Immutability

Because of above intractability, it is a good idea to use package manager like `apt` or `yum` alternative of this cookbook.

Platforms
---------
The following platforms and versions are tested and supported using test-kitchen

* Ubuntu (14.04)
* Debian (8.0)
* CentOS (7.0)

Attributes
-----
See [source](attributes/default.rb) for default values.

## Configurations of MeCab itself
* `node['mecab']['version']` - Flavor of the version you would like to install. Following values are available: 
  * `0.996`
  * `0.995`
  * `0.994`
  * `0.993`
  * `0.991`
  * `0.99`
  * `HEAD` - use the latest commit of MeCab's repository
* `node['mecab']['git_repos']` - Repository to use.
* `node['mecab']['prefix']` - Prefix of path to install built binaries.
* `node['mecab']['utf8-only']` - Enable UTF-8 only mode if its value is true.
* `node['mecab']['clone_timeout']` - Timeout for cloning repository from github.
* `node['mecab']['charset']` - Charset of dictionary. Following values are available:
  * `utf8`
  * `shift-jis`
  * `euc`

## Configurations of dictionaries

### IPADic
* `node['ipadic']['version']` - Flavor of the version of ipadic you would like to install.
  * `2.7.0-20070801`
  * `2.7.0-20070610`
  * `2.7.0-20060707`
  * `2.7.0-20051110`
  * `HEAD` - use the latest commit of MeCab's repository

### JumanDic
* `node['jumandic']['version']` - Flavor of the version of jumandic you would like to install.
  * `7.0-20130310`
  * `5.1-20070304`
  * `HEAD` - use the latest commit of MeCab's repository

### UniDic
* `node['unidic']['version']` - Flavor of the version iof unidic you would like to install.
  * `2.1.2`
  * `2.1.1`
  * `HEAD` - use the latest commit of MeCab's repository

### NaistJDic
* `node['naistjdic']['version']` - Flavor of the version iof naistjdic you would like to install.
  * `0.6.3b-20111013`
  * `0.6.3-20100801`
  * `0.6.2-20100208`
  * `0.6.1-20090630`
  * `0.6.0-20090616`
  * `0.5.0-20090512`
  * `HEAD` - use the latest commit of MeCab's repository

## Configurations of program language bindings

### Java binding

This recipe just build binding and copy it to `node['mecab-java']['install_to']`. You need to place the built resuilts to `java.library.path` to use it.

* `node['mecab-java']['version']` - Flavor of the version of Java binding you would like to install. It requires the same value with MeCab itself.
* `node['mecab-java']['install_to']` - A path to install `MeCab.jar` and `libMeCab.so`. Perhaps

### Perl binding
* `node['mecab-perl']['version']` -  Flavor of the version of Perl binding you would like to install. It requires the same value with MeCab itself.
* `node['mecab-perl']['perl_path']` - Path to perl executable.

### Python binding

* `node['mecab-python']['version']` - Flavor of the version of Python binding you would like to install. It requires the same value with MeCab itself.
* `node['mecab-python']['prefix']` - A prefix of path to install to.


### Perl binding

* `node['mecab-perl']['version']` -  Flavor of the version of Perl binding you would like to install. It requires the same value with MeCab itself.
* `node['mecab-perl']['perl_path']` - Path to perl executable.

### Ruby binding

* `node['mecab-perl']['version']` -  Flavor of the version of Ruby binding you would like to install. It requires the same value with MeCab itself.



Recipes
----------
### Installing MeCab Binary with its dictionary
* `recipe[mecab]` or `recipe[mecab::default]` - Install MeCab and IPA Dictionary. (default)
* `recipe[mecab::ipadic]` - Install MeCab and IPA Dictionary.
* `recipe[mecab::jumandic]` - Install MeCab and Juman Dictionary.
* `recipe[mecab::unidic]` - Install MeCab and Unidic Dictionary.
* `recipe[mecab::naistjdic]` - Install MeCab and NAIST-JDIC Dictionary.

### Installing program language binding of MeCab
* `recipe[mecab::mecab-java]` - Install Java binding
* `recipe[mecab::mecab-perl]` - Install Perl binding
* `recipe[mecab::mecab-python]` - Install Python binding
* `recipe[mecab::mecab-ruby]` - Install Ruby binding

Usage
-----
Just include `mecab` in your node's `run_list`:

* Install MeCab binaries, ipadic, and python binding
```json
{
  "run_list": [
    "recipe[mecab]"
    "recipe[mecab:::mecab-python]
  ]
}
```
* Install MeCab binaries, unidic, and ruby binding
```json
{
  "run_list": [
    "recipe[mecab::unidic]"
    "recipe[mecab:::mecab-ruby]
  ]
}
```

Misc
----
[GitHub Repository](http://github.com/kogecoo/chef-mecab)

License and Author
-------------------
- Author: [kogecoo](http://github.com/kogecoo)
- License: Apache License, Version 2.0 (see [LICENSE](LICENSE))
