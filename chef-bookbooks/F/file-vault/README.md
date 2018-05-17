# Description

Simple cookbook to store secret files in chef-vault.

# Requirements

1. [chef-vault](https://github.com/Nordstrom/chef-vault) plugin for Knife,
available as a Ruby Gem: `gem install chef-vault`
2. Secret files to distribute

## Supported Platforms

This cookbook has been tested on the following platforms:

* CentOS
* Debian

# Attributes

- `node['file-vault']['bag']` - Data_bag to search for secret
  file items. Default value is `file-vault`

- `node['file-vault']['files']` - List of hashes with secret file
  names and items.

# Recipes

- default.rb - Goes through list of files in
  `node['file-vault']['files']` attribute, gets content and creates
  files.

# Usage

- Add secret file to chef-vault data bag

```
$ knife vault -z create file-vault ms_license_key -S "name:ryoko.tinuviel.dev" --admins '' --file /tmp/license.key
```

- Add secret file to chef-vault data bag
- Include this cookbook in target node's run-list
- Set needed files in node's attributes

```ruby
run_list(
  "recipe[file-vault]"
)
override_attributes(
  "file-vault" => {
    "files" => [
      { "name" => "/root/ms_license.key",
        "item" => "ms_license_key"
      }
    ]
  }
)
```
- If everything goes well you will have decrypted file in desired
location

```
[root@ryoko ~]# cat /root/ms_license.key
j3qq4-h7h2v-2hch4-m3hk8-6m8vw
```

# Copyright and license

Copyright 2015 Stanislav Bogatyrev

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
