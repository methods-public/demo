yum_utils Cookbook
==================

This cookbook includes YUM utilities setup recipes.

## Contents

- [Requirements](#requirements)
  - [cookbooks](#cookbooks)
  - [packages](#packages)
- [Attributes](#attributes)
  - [yum_utils::default](#yum_utilsdefault)
- [Usage](#usage)
  - [Recipes](#recipes)
    - [yum_utils::default](#yum_utilsdefault)
    - [yum_utils::mirror](#yum_utilsmirror)
    - [yum_utils::repos](#yum_utilsrepos)
    - [yum_utils::reposync_mirror](#yum_utilsreposync_mirror)
    - [yum_utils::yum-epel](#yum_utilsyum-epel)
- [License and Authors](#license-and-authors)

## Requirements

### cookbooks

- `platform_utils` >= 0.4.0
- `yum` >= 3.0
- `yum-epel`

### packages

none.

## Attributes

### yum_utils::default

|Key|Type|Description (with examples)|Default|
|:--|:--|:--|:--|
|`['yum_utils']['repos']['CentOS-Base']['mirrorlist_ctx']`|String|e.g. `'http://mirrorlist.centos.org'`|`''` (inactive)|
|`['yum_utils']['repos']['CentOS-Base']['baseurl_ctx']`|String|e.g. `'http://ftp.grid.example.com/centos'`|`''` (inactive)|
|`['yum_utils']['repos']['CentOS-Base']['gpgkey']`|String|GPG key path|`'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6'`|
|`['yum_utils']['repos']['epel']['mirrorlist_ctx']`|String|e.g. `'http://mirrors.fedoraproject.org'`|`''` (inactive)|
|`['yum_utils']['repos']['epel']['baseurl_ctx']`|String|e.g. `'http://ftp.grid.example.com/fedora/epel'`|`''` (inactive)|
|`['yum_utils']['repos']['epel']['gpgkey']`|String|GPG key path|`'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6'`|
|`['yum_utils']['mirror']['user']`|String|mirroring user|`'yum-mirror'`|
|`['yum_utils']['mirror']['cron_period']`|String|cron period expression|`'#0 2	* * *'` (inactive)|
|`['yum_utils']['mirror']['base_path']`|String|base directory path|`'/var/spool/yum-mirror'`|
|`['yum_utils']['mirror']['rsync_sources']`|Array|see attributes/default.rb file.|`[]` (empty)|
|`['yum_utils']['reposync_mirror']['user']`|String|mirroring user|`'yum-mirror'`|
|`['yum_utils']['reposync_mirror']['cron_period']`|String|cron period expression|`'#0 3   * * *'` (inactive)|
|`['yum_utils']['reposync_mirror']['base_path']`|String|base directory path|`'/var/spool/yum-reposync-mirror'`|
|`['yum_utils']['reposync_mirror']['yum_conf']`|String|YUM configuration file path|Debian: `'/etc/yum/yum.conf'`, RHEL: `'/etc/yum.conf'`|
|`['yum_utils']['reposync_mirror']['repos_dir']`|String|repository configuration directory path|Debian: `'/etc/yum/repos.d'`, RHEL: `'/etc/yum.repos.d'`|
|`['yum_utils']['reposync_mirror']['repo_ids']`|Array|mirroring repository ids|`[]` (empty)|
|`['yum_utils']['reposync_mirror']['arch']`|String|system architecture|`''`|
|`['yum_utils']['reposync_mirror']['url_alias_with_authority_part']`|Boolean|use url alias with authority part|`true`|

## Usage

### Recipes

#### yum_utils::default

This recipe does nothing.

#### yum_utils::mirror

This recipe sets up mirroring configurations by the rsync.

#### yum_utils::repos

This recipe sets up repository access configurations.

#### yum_utils::reposync_mirror

This recipe sets up mirroring configurations by the reposync.

#### yum_utils::yum-epel

This recipe sets up EPEL yum repository.

## License and Authors

- Author:: whitestar at osdn.jp

```text
Copyright 2013-2017, whitestar

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
