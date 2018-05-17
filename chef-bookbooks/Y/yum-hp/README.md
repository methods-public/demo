yum-hp Cookbook
============

The yum-hp cookbook install HP SPP YUM repo

Requirements
------------
* Chef 12 or higher
* yum cookbook version 3.2.0 or higher

Attributes
----------
The following attributes are set by default

``` ruby
default['yum-hp']['repositories'] = %w{hp-spp}
```

``` ruby
default['yum']['hp-spp']['repositoryid'] = 'hp-spp'
default['yum']['hp-spp']['description'] = 'HP Service Pack Packages for Enterprise Linux 7 - $basearch'
default['yum']['hp-spp']['baseurl'] = 'http://downloads.linux.hpe.com/repo/spp/rhel/7/$basearch/current'
default['yum']['hp-spp']['gpgkey'] = 'http://downloads.linux.hpe.com/SDR/hpPublicKey2048_key1.pub'
default['yum']['hp-spp']['gpgcheck'] = true
default['yum']['hp-spp']['enabled'] = true
default['yum']['hp-spp']['managed'] = true
```

Recipes
-------
* default - Walks through node attributes and feeds a yum_resource
  parameters. The following is an example a resource generated by the
  recipe during compilation.

```ruby
  yum_repository 'hp' do
    baseurl http://downloads.linux.hpe.com/repo/spp/rhel/7/$basearch/current'
    description 'HP Service Pack Packages for Enterprise Linux 7 - $basearch'
    enabled true
    gpgcheck true
    gpgkey 'http://downloads.linux.hpe.com/SDR/hpPublicKey2048_key1.pub'
  end
```

Usage Example
-------------
To disable the hp repository through a Role or Environment definition

```
default_attributes(
  :yum => {
    :hp-spp => {
      :enabled => {
        false
       }
     }
   }
 )
```

License & Authors
-----------------
- Author:: [Nerijus Bendziunas](https://github.com/benner)

```text
Copyright:: 2015 Nerijus Bendziunas

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