id = 'libxslt'

case node['platform_family']
when 'rhel'
  default[id]['packages'] = %w( libxslt )
  default[id]['devel_packages'] = %w( libxslt-devel )
  default[id]['package_manager'] = 'yum'
when 'debian'
  default[id]['packages'] = %w( libxslt1.1 )
  default[id]['devel_packages'] = %w( libxslt1-dev )
  default[id]['package_manager'] = 'apt'
else
  default[id]['packages'] = %w( libxslt )
  default[id]['devel_packages'] = %w( libxslt-devel )
  default[id]['package_manager'] = 'yum'
end

default[id]['install_devel'] = true
