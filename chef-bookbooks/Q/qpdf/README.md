qpdf Cookbook
=============

Installs [QPDF][qpdf] and it's runtime/development libraries using
your OSs package manager.

[QPDF][qpdf] is a command-line program that does structural,
content-preserving transformations on PDF files.

Requirements
============

Cookbooks
---------

On RHEL family distros, the "yum" cookbook is required for obtaining
latest package indexes and adding the EPEL repo which is needed.

On Debian family distros, the "apt" cookbooks is required for obtaining
latest package indexes.

Platforms
---------

The following platforms are supported and have been automatically tested under
[Test Kitchen][testkitchen]:

* Ubuntu 14.04 LTS
* Debian 7.5
* Centos 6.5
* Amazon Linux (2014.03.1)

Other versions of these OSs should work. Alternative Debian and RHEL
family distributions are also assumed to work. Please [report][issues]
any additional platforms you have tested so they can be added.

Usage
=====

Simply include `recipe[qpdf]` in your run_list to have [QPDF][qpdf]
installed.

Recipes
=======

default
-------

Installs [QPDF][qpdf] and it's runtime/development libraries.

Attributes
==========

There are no attributes for this cookbook.

Development
===========

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

### Contributing

Pull requests are very welcome! Ideally create a topic branch for every
separate change you make.

This cookbook uses [ChefSpec][chefspec] for unit tests. I also use [Food
Critic][foodcritic] and [RuboCop][rubocop] to check for style issues.
When contributing it would be very helpful if you could run these via
`bundle exec spec` and `bundle exec style`.

Lastly, there are [Serverspec][serverspec] integration tests for use
ignored. To see all of the available integration test suites just check
`bundle exec rake T` or `bundle exec kitchen list`, it would be great if
you run these tests too, you may however leave out the Amazon Linux test
suite if you do not have an AWS account as it runs on an EC2 instance
(you will be billed for running this).

License and Author
==================

Author:: [Ross Timson][rosstimson]
<[ross@rosstimson.com](mailto:ross@rosstimson.com)>

Copyright 2014, Ross Timson

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


[rosstimson]:         https://github.com/rosstimson
[repo]:               https://github.com/rosstimson/chef-qpdf
[issues]:             https://github.com/rosstimson/chef-qpdf/issues
[qpdf]:               http://qpdf.sourceforge.net/
[chefsepc]:           https://github.com/sethvargo/chefspec
[foodcritic]:         https://github.com/acrmp/foodcritic
[rubocop]:            https://github.com/bbatsov/rubocop
[serverspec]:         https://github.com/serverspec/serverspec
[testkitchen]:        https://github.com/test-kitchen/test-kitchen
