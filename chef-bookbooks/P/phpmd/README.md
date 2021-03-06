[![Build Status](https://travis-ci.org/djoos-cookbooks/phpmd.png)](http://travis-ci.org/djoos-cookbooks/phpmd)

# phpmd cookcook

## Description

This cookbook provides an easy way to install phpmd, PHP Mess Detector.

More information?
http://phpmd.org/download/index.html

## Requirements

### Cookbooks:

* php
* composer
* pdepend

### Platforms:

* Ubuntu
* Debian
* RHEL
* CentOS
* Fedora
* Scientific
* Amazon

## Attributes

* `node['phpmd']['install_method']` - Installation method, "pear", "composer" or "phar" defaults to "pear"
* `node['phpmd']['version']` - The phpmd version that will be installed, defaults to "latest"
* `node['phpmd']['prefix']` - The composer.json bin-dir, defaults to "/usr/bin" (composer install method only)

## Usage

1) include `recipe[phpmd]` in a run list
2) change the attributes
--- OR ---
[override the attribute on a higher level](http://wiki.opscode.com/display/chef/Attributes#Attributes-AttributesPrecedence)

## References

* [phpmd home page] (http://phpmd.org/download/index.html)

## License and Authors

Author: David Joos <development@davidjoos.com>
Copyright: 2016, David Joos

Author: David Joos <david.joos@escapestudios.com>
Author: Escape Studios Development <dev@escapestudios.com>
Copyright: 2013-2015, Escape Studios

Unless otherwise noted, all files are released under the MIT license,
possible exceptions will contain licensing information in them.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.