# chef-alfresco-webserver cookbook
[![Build Status](https://travis-ci.org/Alfresco/chef-alfresco-webserver.svg)](https://travis-ci.org/Alfresco/chef-alfresco-webserver)
[![Cookbook](http://img.shields.io/cookbook/v/alfresco-webserver.svg)](https://github.com/Alfresco/chef-alfresco-webserver)
[![Coverage Status](https://coveralls.io/repos/github/Alfresco/chef-alfresco-webserver/badge.svg)](https://coveralls.io/github/Alfresco/chef-alfresco-webserver)

This cookbook will install the WebServer part of the Alfresco stack.
The default choice is NginX, but it can be expanded to use your own webserver.

## Attributes


| Key | Type | Description | Default |
|-----|------|-------------|---------|
| default['webserver']['engine'] | String | Engine of choice  | nginx  |
| default['webserver']['port'] | Int  |  Webserver public port |  80 |
| default['webserver']['port_ssl'] | Int  |  Public SSL Port |  443 |
| default['webserver']['hostname']  | String  | Matching hostname  |  localhost |
| default['webserver']['lb_hostname'] | String | Hostname/Address of the internal load-balancer  | 127.0.0.1  |
| default['webserver']['lb_protocol'] | String  |  Protocol used to talk to the internal load-balancer |  http |
| default['webserver']['lb_port'] | Int  | Port of the internal load-balancer | 9001 |
| default['webserver']['use_nossl_config']  | Boolean  | Wheter to avoid or use ssl |  true |
| default['webserver']['certs']['filename']  | String  | SSL Certs filename  |  alfresco |
| default['webserver']'certs']['ssl_folder']| String | Folder where the SSL certs will be stored  | /etc/pki/tls/certs  |
| default['webserver']['error_pages']['error_folder'] | String  |  Where the error pages will be stored |  /var/www/html/error_pages |
| default['webserver']['apply_hardening'] | Boolean  | Weter you want this installation to be hardened or no | true |


## Usage

Just add the reference of this cookbook inside your `metadata.rb` file:

```
depends 'alfresco-webserver', '~> v0.7.4'
```


The cookbook is divided in 2 recipes:

- `alfresco-webserver::default` will install and upgrade the webserver of your choice ( specified under the `default['webserver']['engine']` attribute)
- `alfresco-webserver::start` will configure and start the webserver to accept external connections and pass the information to the internal load-balancer.

Include `alfresco-webserver` in your node `run_list`:

```json
{
  "run_list": [
    "recipe[alfresco-webserver::default]",
    "recipe[alfresco-webserver::start]"
  ]
}
```

## License and Authors

Author: Enzo Rivello (<enzo.rivello@alfresco.com>)

Copyright 2016, Alfresco

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
