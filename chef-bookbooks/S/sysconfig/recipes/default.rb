#
# Cookbook: sysconfig
#
# Copyright (c) 2016 Bloomberg L.P., All Rights Reserved.
#
Array(node['sysconfig']['service_name']).each do |s|
  sysconfig s do |r|
    node['sysconfig'][s]['config'].each_pair { |k, v| r.send(k, v) }
  end
end
