Looker Cookbook
====

[![Cookbook Version](https://img.shields.io/cookbook/v/looker.svg)](https://community.opscode.com/cookbooks/looker)

This is a cookbook for setting up an on-premise install of [Looker](http://looker.com), the business intelligence software. 

Please note, this is not an official Looker product; but made by someone who's a customer|user. 


Production Deployment 
-----

With the standard set of defaults, this cookbook will install looker very similarly to the [official looker documentation](https://docs.looker.com/setup-and-management/on-prem-install). Putting things in the the standard locations (`/home/looker/looker...`),  creating a `looker` user and group on the machine, and using the self-signed certificate. 
 
You can override the attributes in a cookbook, role, or environment:

```ruby
node['looker']['looker_user']  = 'looker'
node['looker']['looker_group'] = 'looker'
node['looker']['home_dir']     = '/home/looker/'
```

Versions
----
The default version of looker installed is 5.2. If you'd like to specify a different version, you can override the major and minor versions to the specific versions you require. Be advised, this will only work with _final_ versions of looker, and not pre-release versions. 

```ruby
node['looker']['major_version'] = '4'
node['looker']['minor_version'] = '22'
```

Java JDK
-----
NOTE: Looker 4.2 and greater require a java JDK version of Oracle Java 8 or greater, and, by default, will be part of this installation. You can override the specific java settings in your environment with:

```ruby
node['java']['jdk_version']    = '8'
node['java']['install_flavor'] = 'oracle'
```

SSL
-----
If you'd like to have your looker use a proper [SSL certificate](https://docs.looker.com/setup-and-management/on-prem-install/ssl-setup), you can provide override the `[:looker][:use_custom_ssl]` attribute to be ` true`, and set the following values: 

```ruby
looker: {
  ssl: {
    aws_access_key_id: 'my-access-key',
    aws_secret_access_key: 'my-secret-key',
    s3_bucket: 'my-bucket',
    certificate_key_path: '/path/to/my-cert.key',
    certificate_path: '/path/to/my-cert.pem',
  }
}
```

This allows you to point to a given s3 bucket and grab both your certificate `.pem` file, and it's corresponding `.key`, and the `looker::ssl` recipe will setup a java key store, and give those credentials to the looker script. See [the attributes/ssl.rb](https://github.com/deliv/looker/blob/master/attributes/ssl.rb) for more details. 

Usage
-----

Simply include the `looker` recipe wherever you would like looker to be installed. 


Requirements
-----

Chef 12+
Java JDK 8+

### Platform

* Ubuntu 16.04
* CentOS 7.2

Attributes
-----

See `attributes/default.rb` for default values.

| Attribute  | Note | Default Value |
| ------------- | ------------- | ---------------------------|
| `node['looker']['looker_user']`| The user looker should be run as, and will be created in the `looker::user` recipe. | `'looker'` |
|`node['looker']['looker_group']`| The group the looker user should belong to, and will be created in the `looker::user` recipe. | `'looker'` |
|`node['looker']['home_dir']` | The home directory for the `looker` user | `'/home/looker/'` |
|`node['looker']['looker_dir']` | The looker wokring directory. | `/home/looker/looker`, per the looker convention |
|`node['looker']['looker_jar_file']` | The name of the looker jarfile | `'looker.jar'` |
|`node['looker']['looker_script_name']` |  The execution script to start the looker process. |  `'looker'` |
|`node['looker']['forward_to_443']` | Boolean toggle for setting iptables to forward requests to :443 to :9999 | `true` | 
|`node['looker']['use_custom_ssl']` | Boolean toggle for using a [custom SSL certificate](#ssl). | `false` |
|`node['looker']['looker_user_ulimit']` | The ulimit to be set for the looker user. | `4096` |
|`node['looker']['major_version']` | The major version of looker to install.| `5` |
|`node['looker']['minor_version']` | The minor version of looker to install. | `2` | 


Recipes
-----

### default

Include the default recipe in a run list or recipe to install looker. 

### setup

Included as part of `default`, this recipe configures and installs the looker application, the required JDK dependancies, and starts the looker service. 

### user

Sets up the looker user, group and home directory. This is included by `default.rb`. 

### ssl

Configures a java keystore, and generate and installs custom certificates for your looker server.

### stop

Stops the looker service.

### start

Starts the looker service. 

License and Author
-----
Author: Barclay Loftus (<barclay@deliv.co>)

Copyright (c) 2017 Deliv


MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

