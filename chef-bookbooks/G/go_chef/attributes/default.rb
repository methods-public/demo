default['go']['version'] = '1.9.2'
default['go']['platform'] = node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
default['go']['filename'] = "go#{node['go']['version']}.#{node['os']}-#{node['go']['platform']}.tar.gz"
default['go']['url'] = "https://golang.org/dl/#{node['go']['filename']}"
default['go']['override_url'] = false
default['go']['alternate_url'] = ""
default['go']['install_dir'] = '/usr/local/go/bin'
default['go']['project_home'] = '/projects'
default['go']['gopath'] = "#{default['go']['project_home']}/src"
default['go']['gobin'] = "#{default['go']['project_home']}/bin"
default['go']['dir_permissions'] = '0777'
