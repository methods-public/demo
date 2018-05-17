[![Build Status](https://travis-ci.org/upcFrost/chef_corosync_cookbook.svg?branch=master)](https://travis-ci.org/upcFrost/chef_corosync_cookbook)

Corosync Cookbook
=================

Installs and configures Corosync Cluster Engine.

Requirements
------------
#### Platforms
- Debian 8
- Ubuntu >= 14.04
- RHEL/CentOS >= 6
- openSUSE >= 13.1
- SLE 12/12.1

#### Chef
- Chef 11+

#### Cookbooks
- hostsfile

Recipes
-------

###default

Installs the Corosync, and manages the Corosync service. 
The recipe does not at this time manage any configuration.

Resources
---------

###default

The default resource to configure the Corosync.

####Properties
The following list contains only some of the properties.
For other options please see the `corosync.conf.5` manual and the ```resources/default.rb``` file.

- `totem_version` - Integer. Specifies the version of the configuration file.
              Currently the only valid version for this directive is 2.
- `totem_crypto_cipher` - This specifies which  cipher  should  be  used  to  encrypt  all
              messages.   Valid  values  are  none  (no  encryption),  aes256,
              aes192, aes128 and 3des.  Enabling crypto_cipher, requires  also
              enabling of crypto_hash.
- `totem_crypto_hash` - This specifies which  HMAC  authentication  should  be  used  to
              authenticate   all   messages.   Valid   values   are  none  (no
              authentication), md5, sha1, sha256, sha384 and sha512.
- `totem_secauth` - This  specifies  that HMAC/SHA1 authentication should be used to
              authenticate all messages.  It further specifies that  all  data
              should  be  encrypted with the nss library and aes256 encryption
              algorithm to protect data from eavesdropping.
              WARNING: This parameter is deprecated. It's  recomended  to  use
              combination of crypto_cipher and crypto_hash.
- `totem_transport` - This directive controls the transport mechanism  used.   If  the
              interface to which Corosync is binding is an RDMA interface such
              as RoCEE or Infiniband, the "iba" parameter  may  be  specified.
              To  avoid  the  use  of  multicast entirely, a unicast transport
              parameter "udpu" can be specified.  This requires specifying the
              list  of  members  in nodelist directive, that could potentially
              make up the membership before deployment.
- `node_list` - Node list in the following format.
```javascript
  [
    {
    'ring: Int', 
    'node_name: String', 
    'ip_addr: String'
    },
    {
    ...
    }
  ]
```
- `totem_interface_bindnetaddr` - Interface to bind the ring
- `totem_ip_version` - Specifies version of IP to use for communication. Value  can  be
              one of ipv4 or ipv6. Default (if unspecified) is ipv4.
- `totem_heartbeat_failures_allowed` - Configures  the  optional  HeartBeating
              mechanism  for  faster  failure  detection.  Keep  in  mind that
              engaging this mechanism in lossy  networks  could  cause  faulty
              loss  declaration  as  the  mechanism  relies on the network for
              heartbeating.

Usage
-----
- Add ```depends 'corosync'``` to your cookbook's metadata.rb
- Use recipe ```'default'``` to install the Corosync

###Resource-based config

- Use the resources shipped in cookbook in a recipe, the same way you'd
  use core Chef resources (file, template, directory, package, etc).
- Some healthy defaults are provided (e.g. totem version)

```ruby
include_recipe 'corosync'

corosync 'config' do
  totem_transport 'udpu'
  totem_interface_bindnetaddr node_ip
  node_list corosync_node_list
  action :create
end
```

###JSON-based config

- Specify the JSON attributes for your node as follows

```javascript
"normal": {
  "corosync": {
    "config": {
      "totem": {
        "version": 2,
        "secauth": "on"
      }
    }
  }
}
```

- Call the resource ```default```

```ruby
corosync 'config' do
  action :create
end
```
