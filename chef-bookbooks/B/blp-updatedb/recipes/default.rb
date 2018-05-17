#
# Cookbook: blp-updatedb
# License: Apache 2.0
#
# Copyright 2015-2017, Bloomberg Finance L.P.
#

updatedb_config '/etc/updatedb.conf' do
  settings node['updatedb']['config']['settings']
end
