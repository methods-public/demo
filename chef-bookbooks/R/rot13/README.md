# <a name="title"></a> Rot13 Chef Cookbook

[![Build Status](https://secure.travis-ci.org/ut-cookbooks/rot13.png?branch=master)](http://travis-ci.org/ut-cookbooks/rot13)

## <a name="description"></a> Description

Chef cookbook for securing sensitive payloads on nodes using a classic Caesar cipher. You know, 'cause it had to be done.

* Source Code: https://github.com/ut-cookbooks/rot13
* Community Site: http://community.opscode.com/cookbooks/rot13

## <a name="usage"></a> Usage

Simply add a `depends "rot13"` in one of your cookbooks or include `recipe[rot13]` in your run\_list and you will have access to the `rot13_vault` [lwrp](#lwrps).

## <a name="requirements"></a> Requirements

### <a name="requirements-chef"></a> Chef

Tested on 11.10.4 but newer and older versions should work just fine.
File an [issue][issues] if this isn't the case.

### <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that the
recipes run on these platforms without error:

* ubuntu (12.04)
* centos (6.4)

Please [report][issues] any additional platforms so they can be added.

### <a name="requirements-cookbooks"></a> Cookbooks

This cookbook has **no** cookbook dependencies.

## <a name="recipes"></a> Recipes

### <a name="recipes-default"></a> default

This recipe, gloriously, does nothing.

## <a name="attributes"></a> Attributes

This cookbook depends on **no** attributes.

## <a name="lwrps"></a> Resources and Providers

### <a name="lwrps-rot13-vault"></a> rot13\_vault

### <a name="lwrps-rot13-vault-actions"></a> Actions

| Action | Description               | Default |
|--------|---------------------------|---------|
| create | Creates the encoded file. | Yes     |

### <a name="lwrps-rot13-vault-attributes"></a> Attributes

| Attribute | Description               | Default Value |
|-----------|---------------------------|---------------|
| path      | **Name attribute:** The path for the file. | `nil` |
| owner     | The owner of the file. | `nil` |
| group     | The group ownership of the file. | `nil` |
| mode      | The permissions of the file. | `nil` |
| payload   | The content that is to be encoded in the file. | `nil` |

#### <a name="lwrps-rot13-vault-examples"></a> Examples

    rot13_vault "lockdown" do
      path    "/etc/private/nopeek"
      owner   "root"
      group   "root"
      mode    "0400"
      payload "please don't decode this"
    end

    rot13_vault "/tmp/nothin" do
      payload <<-PAYLOAD
    once upon a time, ...
    PAYLOAD
    end

## <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

## <a name="license"></a> License and Author

Author:: [Fletcher Nichol][fnichol] (<fnichol@nichol.ca>) [![endorse](http://api.coderwall.com/fnichol/endorsecount.png)](http://coderwall.com/fnichol)

Copyright 2014, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[fnichol]:      https://github.com/fnichol
[repo]:         https://github.com/ut-cookbooks/rot13
[issues]:       https://github.com/ut-cookbooks/rot13/issues
