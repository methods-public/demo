default['apt']['compile_time_update'] = true

default['yum-epel']['repositories'] = %w{epel epel-testing}

default['mono3']['source']['dependencies'] = %w[
  libgdiplus
  zlib1g-dev
  autoconf
  automake
  libtool
  gettext
]

default['mono3']['install_method'] = 'package'

default['mono3']['source']['git_uri'] = 'git://github.com/mono/mono.git'
default['mono3']['source']['git_branch'] = 'master'

case node['platform_family']
when 'rhel', 'fedora'
  default['mono3']['yum_repository'] = 'http://download.mono-project.com/repo/centos/'
  default['mono3']['yum_repository_key'] = 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
when 'debian'
  default['mono3']['apt_repository'] = 'http://download.mono-project.com/repo/debian'
  default['mono3']['apt_keyserver'] = 'keyserver.ubuntu.com'
  default['mono3']['apt_repository_key'] = '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
end
