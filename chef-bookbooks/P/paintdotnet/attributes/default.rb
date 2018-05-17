default['paintdotnet']['version']		= '4.0.1'
default['paintdotnet']['filename']		= "paint.net.#{node['paintdotnet']['version']}.install"
default['paintdotnet']['unzipdir']		= 'c:/temp'
default['paintdotnet']['downloadurl']	= "http://www.dotpdn.com/files/#{node['paintdotnet']['filename']}.zip"
default['paintdotnet']['checksum']		= '66d32ad200d9e736b162e3272db0c70d7a043020'
default['paintdotnet']['package_name']	= "paint.net"
