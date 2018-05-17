yum-passenger Cookbook
======================

The yum-passenger cookbook takes over management of the default
repositoryids shipped by [Phusion Passenger][1]. It allows attribute
manipulation of `passenger`, and `passenger-source`.

Requirements
------------
* Chef 11 or higher
* yum cookbook version 3.0.0 or higher

Attributes
----------
The following attributes are set by default

```ruby
default['yum-passenger']['repositories'] = %w{passenger passenger-source}
```

```ruby
default['yum']['passenger']['repositoryid'] = 'passenger'
default['yum']['passenger']['baseurl'] = 'https://oss-binaries.phusionpassenger.com/yum/passenger/el/$releasever/$basearch'
default['yum']['passenger']['repo_gpgcheck'] = true
default['yum']['passenger']['gpgcheck'] = false
default['yum']['passenger']['enabled'] = true
default['yum']['passenger']['gpgkey'] = 'https://packagecloud.io/gpg.key'
default['yum']['passenger']['sslverify'] = true
default['yum']['passenger']['sslcacert'] = '/etc/pki/tls/certs/ca-bundle.crt'
default['yum']['passenger']['managed'] = true
```

```ruby
default['yum']['passenger-source']['repositoryid'] = 'passenger-source'
default['yum']['passenger-source']['baseurl'] = 'https://oss-binaries.phusionpassenger.com/yum/passenger/el/$releasever/SRPMS'
default['yum']['passenger-source']['repo_gpgcheck'] = true
default['yum']['passenger-source']['gpgcheck'] = false
default['yum']['passenger-source']['enabled'] = true
default['yum']['passenger-source']['gpgkey'] = 'https://packagecloud.io/gpg.key'
default['yum']['passenger-source']['sslverify'] = true
default['yum']['passenger-source']['sslcacert'] = '/etc/pki/tls/certs/ca-bundle.crt'
default['yum']['passenger-source']['managed'] = true
```

Usage Example
-------------
To disable the passenger repository through a Role or Environment definition

```
default_attributes(
  :yum => {
    :passenger => {
      :enabled => {
        false
       }
     }
   }
 )
```

More Examples
-------------
Point the passenger repositories at an internally hosted server.

```
node.default['yum']['passenger']['enabled'] = true
node.default['yum']['passenger']['mirrorlist'] = nil
node.default['yum']['passenger']['baseurl'] = 'https://internal.example.com/centos/6/os/x86_64'
node.default['yum']['passenger']['sslverify'] = false

include_recipe 'yum-passenger'
```

## License and Authors

Author:: Jason Barnett (<chef@mynameisjason.com>)

[1]: https://www.phusionpassenger.com/install_redhat
