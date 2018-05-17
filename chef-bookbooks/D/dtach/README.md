dtach Cookbook
==============

Compiles and installs dtach.

dtach is a tiny program that emulates the detach feature of screen.

Requirements
------------

There are no further dependencies, the cookbook will use plain old Chef to
install the very minimal requirements dtach needs to build.

Attributes
----------

### version

The version of dtach that will be installed.

The default is `0.8`.

### checksum

sha256 checksum of the tarball.

The default is the checksum that matches with dtach-0.8.tar.gz

### install_path

The default location that the compiled dtach executable will be moved to.

The default is `/usr/local/bin`


Usage
-----

Simply include `recipe[dtach]` in your `run_list`.

Development
-----------

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

License and Author
------------------

Author:: [Ross Timson][rosstimson] (<ross@rosstimson.com>)

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


[rosstimson]: https://github.com/rosstimson
[repo]:       https://github.com/rosstimson/chef-dtach
[issues]:     https://github.com/rosstimson/chef-dtach/issues
[dtach]:      http://dtach.sourceforge.net/
