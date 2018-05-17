# The version is the only attribute that needs to be changed when a newer version is released.
if platform_family?('windows')
  default['filezilla']['client']['version'] = '3.14.1'
  default['filezilla']['server']['version'] = '0.9.54'
  default['filezilla']['server']['filename_version'] = '0_9_54' # The FileZilla server filename uses underscores instead of periods


  client_version = default['filezilla']['client']['version']
  server_version = default['filezilla']['server']['version']
  server_filename_version = default['filezilla']['server']['filename_version']

  default['filezilla']['client']['http_url'] = 'http://iweb.dl.sourceforge.net/project/filezilla/FileZilla_Client/'
  default['filezilla']['client']['source'] = File.join(node['filezilla']['client']['http_url'],"#{client_version}")
  default['filezilla']['client']['location'] = File.join(node['filezilla']['client']['source'],'/')

  default['filezilla']['server']['http_url'] = 'http://iweb.dl.sourceforge.net/project/filezilla/FileZilla Server/'
  default['filezilla']['server']['source'] = File.join(node['filezilla']['server']['http_url'],"#{server_version}")
  default['filezilla']['server']['location'] = File.join(node['filezilla']['server']['source'],'/')

  if node['kernel']['machine'] == 'x86_64' # Check Windows box for 64-bit
  	default['filezilla']['client']['exe'] = "FileZilla_#{client_version}_win64-setup.exe"
  else
  	default['filezilla']['client']['exe'] = "FileZilla_#{client_version}_win32-setup.exe"
  end

  default['filezilla']['server']['exe'] = "FileZilla_Server-#{server_filename_version}.exe"

  default['filezilla']['client']['url'] = File.join(node['filezilla']['client']['location'],node['filezilla']['client']['exe'])

  default['filezilla']['server']['url'] = File.join(node['filezilla']['server']['location'],node['filezilla']['server']['exe'])
end
