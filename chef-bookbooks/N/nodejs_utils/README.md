nodejs_utils Cookbook
=====================

This cookbook installs `n`, `nvm` (Node.js Version Managers) setup scripts.

## Contents

- [Requirements](#requirements)
    - [platforms](#platforms)
    - [packages](#packages)
    - [cookbooks](#cookbooks)
- [Attributes](#attributes)
- [Usage](#usage)
    - [Recipes](#recipes)
        - [nodejs_utils::default](#nodejs_utilsdefault)
        - [nodejs_utils::n-installer](#nodejs_utilsn-installer)
        - [nodejs_utils::nvm-installer](#nodejs_utilsnvm-installer)
- [License and Authors](#license-and-authors)

## Requirements

### platforms
- Debian >= 8.0
- Ubuntu >= 14.04
- CentOS, RHEL >= 7.3

### packages
- none.

### cookbooks
- none.

## Attributes

|Key|Type|Description, example|Default|
|:--|:--|:--|:--|
|`['nodejs_utils']['nvm']['version']`|String|latest: 'master'|`'v0.33.6'`|

## Usage

### Recipes

#### nodejs_utils::default

This recipe does nothing.

#### nodejs_utils::n-installer

This recipe installs the `n` setup script.

#### nodejs_utils::nvm-installer

This recipe installs the `nvm` setup script.

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2017, whitestar

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
