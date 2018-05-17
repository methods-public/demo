Dynamic Attributes
==================

Description
-----------

Interprets and rewrites node attributes defined in roles to provide more
dynamicity. For instance, it can be used to get the value of the fqdn in
a role by setting an attribute to "node\['fqdn'\]". This cookbook will
replace "node\['fqdn'\]" by its true value at execution (in compile phase) so
it is available to other cookbooks. This allows a role to be more shareable
between nodes.

Different methods of substitution are available. Each method has its own recipe
but all are included by default recipe.

Known limitation: derived attributes defined in attribute files will not read
the rewritten values. This is because attribute files are initialized before
recipes are compiled, so before the substitutions take place. This will
probably not be fixed as it is actually a feature to do the substitution during
the cookbook compilation phase, so you may use as source an attribute defined
in some other cookbook. Moreover, this limitation should not be encountered
very often and can be easily overcome by redefining the derived attributes.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

It should work on any platform as it is pure ruby. However it is just tested
with kitchen on a Centos 7 docker image.

Usage
-----

### To be started

Add the default recipe in you runlist in any position you
want, knowing that a source must be before and a reader must be after to see
the effect in compile phase.

You may also want to tweak attributes (like whitelisting).

Read recipes documentation for more details.

### Test

This cookbook is tested with kitchen on a Centos 7 docker image. A test
cookbook is used to extract attributes after default recipe has run.

For more information, see [.kitchen.yml](.kitchen.yml) and [test](test)
directory.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

### default

Include *replace* and then *eval* recipes. So it performs all substitutions,
one after another. Attribute key (keys in hashmaps) are also modified if
needed.

Note that by default, *eval* has no effect as no attribute is whitelisted. In
contrary, *replace* is executed on all attributes.

You can look at examples defined as tests for more information.

### eval

Evaluate (with the use of eval method) whitelisted (default: none) attributes
as if there were referenced in a double-quote string and set the result as new
attribute value. For instance, an attribute with value "1+#{1+1}" will be
rewrited as "1+2" (as it would be in ruby).

Be careful with this substitution method as you can execute any ruby code. Be
sure to whitelist only the attributes you need.

You can look at examples defined as tests for more information.

### replace

Replace (recursively) whitelisted (default: all) attributes of the form
"node\['foo'\]\['bar'\]" to their "true" value. It is not a string
interpolation nor a substring replacement: it will work solely if the
attributes value is exactly "node\['something'\]".

If the target value does not exist (like "node\['doesnotexist'\]"), it keeps
the current value (that is the string "node\['doesnotexist'\]").

You can look at examples defined as tests for more information.

Libraries
---------

Provide implementation of the different methods: eval and replace.

Resources/Providers
-------------------

None.

Changelog
---------

Available in [CHANGELOG](CHANGELOG).

Contributing
------------

Please read carefully [CONTRIBUTING.md](CONTRIBUTING.md) before making a merge
request.

License and Author
------------------

- Author:: Samuel Bernard (<samuel.bernard@gmail.com>)

```text
Copyright (c) 2016 Sam4Mobile, 2017 Make.org

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
