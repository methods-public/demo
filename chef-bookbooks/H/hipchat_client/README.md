HipChat Client Cookbook
=======================

This cookbook installs the HipChat client on either Mac or Windows.

Requirements
------------

Chef 0.10.10+ and Ohai 6.10+ for `platform_family` use.

## Platform

* Mac OS X
* Windows

## Cookbooks

* `windows`

Attributes
----------

None.

Usage
-----

Include the `hipchat_client::default` recipe in your node's `run_list`.
It will `include_recipe` the correct recipe for your operating system
platform.

To-Do
-----

* Unit tests
* Refactor URLs into node attributes
* Unix/Linux support?

License and Authors
-------------------

* Author: Erin L. Kolp (<ekolp@kickbackpoints.com>)
* Copyright: 2013-2017 Julian C. Dunn.

```text
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
