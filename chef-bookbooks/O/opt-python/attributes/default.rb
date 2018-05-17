default['opt-python']['version'] = "2.7.8"
default['opt-python']['install_dir'] = "/opt"
default['opt-python']['download_dir'] = "/tmp"
default['opt-python']['download_url'] = "http://www.python.org/ftp/python/#{node['opt-python']['version']}/Python-#{node['opt-python']['version']}.tgz"

# Packages
case node['platform_family']
when 'rhel'
  default['opt-python']['packages'] = %w[zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel]
end
