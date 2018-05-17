default['postgresql_studio']['version']= '1.2'


urls = {
  '1.0' => 'http://www.postgresqlstudio.org/?ddownload=839',
	'1.1' => 'http://www.postgresqlstudio.org/?ddownload=25940',
	'1.2' => 'http://www.postgresqlstudio.org/?ddownload=47438'
}

default['postgresql_studio']['download_url']= urls[postgresql_studio['version']]
