# daun cookbook

[![Build Status](https://travis-ci.org/ceilfors/cookbook-daun.svg?branch=master)](https://travis-ci.org/ceilfors/cookbook-daun)
[![Cookbook Version](https://img.shields.io/cookbook/v/daun.svg)](https://supermarket.chef.io/cookbooks/daun)

A chef library cookbook that provides recipes and resources for daun rubygem.


## Requirements

### Platforms

- Debian / Ubuntu derivatives
- RHEL and derivatives
- openSUSE / SUSE Linux Enterprises

### Chef

- Chef 12.5+

## Recipes

### default
Including this recipe is a prerequisite of using the resources in this cookbook.
The default recipe installs the required Linux packages to install libgit2/rugged,
then install daun rubygem to Chef for the chef resources to use.

## Resources

### daun (default)

Checkouts a daun repository to the set destination. 

#### properties

- `destination`: The checkout destination
- `repository`: The repository to be checked out
- `config`: The daun repository options that will be set before the checkout.

#### actions

- `checkout` (default)

#### Examples

```
daun '/tmp/gq' do
  repository 'https://github.com/ceilfors/gq.git'
  config('daun.tag.limit' => 3,
         'daun.tag.blacklist' => 'mytag',
         'daun.branch.blacklist' => 'mybranch')
end
```

# Copyright

```text
Copyright 2016 Wisen Tanasa

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
