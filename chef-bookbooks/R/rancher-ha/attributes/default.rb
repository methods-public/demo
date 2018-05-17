# Docker settings
default['docker']['version'] = '17.06.0'

# Server settings
default['rancher']['server']['image'] = 'rancher/server'
default['rancher']['server']['version'] = 'stable'
default['rancher']['server']['node_name'] = 'server'
default['rancher']['server']['listening_port'] = '8080'

# DB settings
default['rancher']['db']['image'] = 'mariadb'
default['rancher']['db']['version'] = '10.2.14'
default['rancher']['db']['dbhost'] = 'mysql'
default['rancher']['db']['dbport'] = '3306'
default['rancher']['db']['dbuser'] = 'root'
default['rancher']['db']['dbname'] = 'rancher'

# Nginx
default['nginx']['server']['image'] = 'nginx'
default['nginx']['server']['version'] = 'stable'
default['nginx']['dir'] = '/etc/nginx/conf.d'
default['nginx']['cert_dir'] = '/etc/nginx/ssl'

# Self-signed certificate
default['nginx']['cert']['country'] = 'AU'
default['nginx']['cert']['state'] = 'Some-State'
default['nginx']['cert']['locality'] = ''
default['nginx']['cert']['org'] = 'Internet Widgits Pty Ltd'
default['nginx']['cert']['org_unit'] = ''
default['nginx']['cert']['common_name'] = 'example.com'
default['nginx']['cert']['expiration'] = 365
