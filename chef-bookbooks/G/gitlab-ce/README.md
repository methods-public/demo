# gitlab-ce
[![Build Status](https://travis-ci.org/kemra102/gitlab-ce-cookbook.svg?branch=master)](https://travis-ci.org/kemra102/gitlab-ce-cookbook)

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Attributes](#attributes)
4. [Usage](#usage)
5. [Contributing](#contributing)
6. [License & Authors](#license-and-authors)

## Overview

This module manages the installation & configuration for Gitlab CE Omnibus Edition.

## Requirements

None.

## Attributes

### gitlab-ce::default

| Key                               | Type      | Description                                   | Default |
|:---------------------------------:|:---------:|:---------------------------------------------:|:-------:|
| `['gitlab-ce']['dependencies']` | `Array` | List of packages that Gitlab depends upon. | `['curl', 'policycoreutils', 'openssh-server', openssh-clients]` |
| `['gitlab-ce']['manage_postfix']` | `Boolean` | Determines if `postfix` should be managed or not. Gitlab uses Postfix to send outgoing mail. | `true` |
| `['gitlab-ce']['manage_repo']` | `Boolean` | Determines if the cookbook should manage the Gitlab CE Omnibus repo or not. | `true` |

The following variables are used to help populate Gitlab's config file:

| Key                               | Type      | Description                                   | Default |
|:---------------------------------:|:---------:|:---------------------------------------------:|:-------:|
| `['gitlab-ce']['config']['enable_https']` | `Array` | Determines if the WebUI should be served over https or not. | `false` |
| `['gitlab-ce']['config']['external_url']` | `String` | External URL that the WebUI is available on. | `node['fqdn']` |
| `['gitlab-ce']['config']['git_data_dir']` | `String` | Directory that Gitlab stores data. | `/var/opt/gitlab/git-data` |
| `['gitlab-ce']['config']['manage_accounts']` | `Boolean` | Determines if Gitlab should manage accounts or not. | `true` |

A number of config file values can also be supplied by creating none default attributes for them in a Hash style format, for example:

```ruby
default['gitlab-ce']['config']['gitlab_rails']['true'] = true
```

The following config items can currently be set in this way:

* `gitlab_rails`
* `gitlab_workhorse`
* `user`
* `unicorn`
* `sidekiq`
* `gitlab_shell`
* `postgresql`
* `redis`
* `web_server`
* `nginx`
* `logging`

Please see the official Gitlab docs for more info on the configuration options that are available.

## Usage

You must always include the default recipe:

```ruby
include_recipe 'gitlab-ce::default'
```

Other than the above all config is done via [Attributes](#attirbutes).

## Contributing

If you would like to contribute to this cookbook please follow these steps;

1. Fork the repository on Github.
2. Create a named feature branch (like `add_component_x`).
3. Write your change.
4. Write tests for your change (if applicable).
5. Write documentation for your change (if applicable).
6. Run the tests, ensuring they all pass.
7. Submit a Pull Request using GitHub.

## License and Authors

License: [BSD 2-Clause](https://tldrlegal.com/license/bsd-2-clause-license-\(freebsd\))

Authors:

  * [Danny Roberts](https://github.com/kemra102)
  * [All Contributors](https://github.com/kemra102/yumserver-cookbook/graphs/contributors)
