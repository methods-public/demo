#
# Cookbook: hosts_allow-cookbook
#
# Copyright (c) 2016 Bloomberg L.P., All Rights Reserved.
#
#
hosts_allow node['hosts_allow']['path'] do
  settings node['hosts_allow']['settings']
end
