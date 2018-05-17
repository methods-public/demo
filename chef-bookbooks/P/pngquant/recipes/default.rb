case node['platform_family']
when 'debian', 'rhel'
  package 'pngquant'
end
