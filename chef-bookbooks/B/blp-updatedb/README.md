# blp-updatedb cookbook

[![Build Status](https://img.shields.io/travis/bloomberg-cookbooks/updatedb.svg)](https://travis-ci.org/bloomberg-cookbooks/updatedb)
[![Cookbook Version](https://img.shields.io/cookbook/v/blp-updatedb.svg)](https://supermarket.chef.io/cookbooks/blp-updatedb)
[![License](https://img.shields.io/github/license/bloomberg-cookbooks/updatedb.svg?maxAge=2592000)](http://www.apache.org/licenses/LICENSE-2.0)

Cookbook which configures UpdateDB.

## Platforms

The following platforms are tested automatically
using [Test Kitchen][0], in Docker, with
the [default suite of integration tests][2]:

- Ubuntu 12.04/14.04/16.04
- CentOS (RHEL) 6/7

## Basic Usage
The [default recipe](recipes/default.rb) gives you the ability to pass
attributes to tune all of the settings in the updatedb config file.
There are currently defaults set in the [attributes](attributes/default.rb). You can modify these as you please.  
You can tweak the settings in the Policefile.rb or directly using
attributes. All UpdateDB specific settings should use underscores like
the examples below.

### Recipe
```ruby
default['updatedb']['config']['settings']['prune_bind_mounts'] = 'yes'
default['updatedb']['config']['settings']['prunenames'] = '.git .bzr .hg .svn'
default['updatedb']['config']['settings']['prunefs'] = '/tmp /var/spool /media /home/.ecryptfs'
default['updatedb']['config']['settings']['prunepaths'] = 'NFS nfs nfs4 rpc_pipefs afs binfmt_misc proc smbfs autofs iso9660 ncpfs coda devpts ftpfs devfs mfs shfs sysfs cifs lustre tmpfs usbfs udf fuse.glusterfs fuse.sshfs curlftpfs ecryptfs fusesmb devtmpfs'
```

### Policyfile
``` ruby
name 'updatdb'
default_source :community
run_list 'blp-updatedb::default'
default['updatedb']['config']['settings']['prune_bind_mounts'] = 'yes'

override['updatedb']['config']['settings']['prunenames'] = '.git .bzr .hg .svn'
override['updatedb']['config']['settings']['prunefs'] = '/tmp /var/spool /media /home/.ecryptfs'
override['updatedb']['config']['settings']['prunepaths'] = 'NFS nfs nfs4 rpc_pipefs afs binfmt_misc proc smbfs autofs iso9660 ncpfs coda devpts ftpfs devfs mfs shfs sysfs cifs lustre tmpfs usbfs udf fuse.glusterfs fuse.sshfs curlftpfs ecryptfs fusesmb devtmpfs'
```

[0]: https://docs.ruby-lang.org/en/2.1.0/Gem/ConfigFile.html
[1]: https://rubygems.org/
[2]: https://github.com/bloomberg-cookbooks/gemrc/blob/master/test/integration/default/default_spec.rb
[3]: https://github.com/chef/omnibus
[4]: https://github.com/bloomberg-cookbooks/gemrc/blob/master/recipes/default.rb
