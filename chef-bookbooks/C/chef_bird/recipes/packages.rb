unless node['bird']['package_ipv4'].nil?
  package node['bird']['package_ipv4']
end

unless node['bird']['package_ipv6'].nil?
  package node['bird']['package_ipv6']
end
