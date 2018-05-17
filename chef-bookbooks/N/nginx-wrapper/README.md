Nginx wrapper
=============

Description
-----------

Cookbook used to install and configure Nginx.
This cookbook wrap chef\_nginx, certificates and nginx\_conf cookbooks.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

A *systemd* managed distribution:
- RHEL Family 7, tested on Centos

Usage
-----

Include the default recipe in your run\_list.

Resources from chef\_nginx, certificates and nginx\_conf cookbooks are
wrapped.

For example if you need to deploy a simple config to listen on port 443 for
test.local as server name and using ssl certs stored in an encrypted data\_bag:

```
"nginx_conf": {
  "confs": [
   "test.local config": {
     "listen": "80",
     "root": "/usr/share/nginx/html"
     "server_name": "test.local"
   }
  ]
},
"nginx-wrapper": {
  "ssl_configs": {
    "data_bag": "nginx-certs",
    "data_bag_type": "encrypted",
    "cert_path": "/etc/nginx/ssl",
    "nginx_cert": true,
    "create_subfolders": false
  }
}
```

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

### default

Include `chef_nginx::default`, `nginx-wrapper::ssl_certs` and
`nginx_conf::default` recipes

### ssl\_certs

Create ssl directory for nginx and deploy certs.

This directory is defined using the following attribute:
`node['nginx-wrapper']['ssl_certs_dir']`

SSL certificates are deployed through an encrypted data\_bag.

Changelog
---------

Available in [CHANGELOG.md](CHANGELOG.md).

Contributing
------------

Please read carefully [CONTRIBUTING.md](CONTRIBUTING.md) before making a merge
request.

License and Author
------------------

- Author:: Florian Philippon (<florian.philippon@s4m.io>)

```text
Copyright (c) 2016 Sam4Mobile

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
