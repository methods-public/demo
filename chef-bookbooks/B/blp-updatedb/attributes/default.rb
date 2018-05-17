#
# Cookbook: blp-updatedb
# License: Apache 2.0
#
# Copyright 2015-2017, Bloomberg Finance L.P.
#

default['updatedb']['config']['path'] = '/etc/updatedb.conf'

default['updatedb']['config']['settings']['prune_bind_mounts'] = 'yes'
default['updatedb']['config']['settings']['prunenames'] = '.git .bzr .hg .svn'
default['updatedb']['config']['settings']['prunefs'] = '/tmp /var/spool /media /home/.ecryptfs'
default['updatedb']['config']['settings']['prunepaths'] = 'NFS nfs nfs4 rpc_pipefs afs binfmt_misc proc smbfs autofs iso9660 ncpfs coda devpts ftpfs devfs mfs shfs sysfs cifs lustre tmpfs usbfs udf fuse.glusterfs fuse.sshfs curlftpfs ecryptfs fusesmb devtmpfs'
