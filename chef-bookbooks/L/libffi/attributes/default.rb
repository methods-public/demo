id = 'libffi'

case node['platform_family']
when 'rhel'
  default[id]['packages'] = %w( libffi )
  default[id]['devel_packages'] = %w( libffi-devel )
  default[id]['package_manager'] = 'yum'
when 'debian'
  default[id]['packages'] = %w( libffi6 )
  default[id]['devel_packages'] = %w( libffi-dev )
  default[id]['package_manager'] = 'apt'
else
  default[id]['packages'] = %w( libffi )
  default[id]['devel_packages'] = %w( libffi-devel )
  default[id]['package_manager'] = 'yum'
end

default[id]['install_devel'] = true
