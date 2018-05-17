case node['platform_family']
when 'debian', 'rhel'
  package 'jpegoptim'
end
