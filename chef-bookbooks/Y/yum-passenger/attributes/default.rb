default['yum-passenger']['repositories'] = %w{passenger passenger-source}

default['yum']['passenger']['repositoryid'] = 'passenger'
default['yum']['passenger']['description'] = 'passenger'
default['yum']['passenger']['baseurl'] = 'https://oss-binaries.phusionpassenger.com/yum/passenger/el/$releasever/$basearch'
default['yum']['passenger']['repo_gpgcheck'] = true
default['yum']['passenger']['gpgcheck'] = false
default['yum']['passenger']['enabled'] = true
default['yum']['passenger']['gpgkey'] = 'https://packagecloud.io/gpg.key'
default['yum']['passenger']['sslverify'] = true
default['yum']['passenger']['sslcacert'] = '/etc/pki/tls/certs/ca-bundle.crt'
default['yum']['passenger']['managed'] = true

default['yum']['passenger-source']['repositoryid'] = 'passenger-source'
default['yum']['passenger-source']['description'] = 'passenger-source'
default['yum']['passenger-source']['baseurl'] = 'https://oss-binaries.phusionpassenger.com/yum/passenger/el/$releasever/SRPMS'
default['yum']['passenger-source']['repo_gpgcheck'] = true
default['yum']['passenger-source']['gpgcheck'] = false
default['yum']['passenger-source']['enabled'] = true
default['yum']['passenger-source']['gpgkey'] = 'https://packagecloud.io/gpg.key'
default['yum']['passenger-source']['sslverify'] = true
default['yum']['passenger-source']['sslcacert'] = '/etc/pki/tls/certs/ca-bundle.crt'
default['yum']['passenger-source']['managed'] = true

#[passenger]
#name=passenger
#baseurl=https://oss-binaries.phusionpassenger.com/yum/passenger/el/$releasever/$basearch
#repo_gpgcheck=1
#gpgcheck=0
#enabled=1
#gpgkey=https://packagecloud.io/gpg.key
#sslverify=1
#sslcacert=/etc/pki/tls/certs/ca-bundle.crt

#[passenger-source]
#name=passenger-source
#baseurl=https://oss-binaries.phusionpassenger.com/yum/passenger/el/$releasever/SRPMS
#repo_gpgcheck=1
#gpgcheck=0
#enabled=1
#gpgkey=https://packagecloud.io/gpg.key
#sslverify=1
#sslcacert=/etc/pki/tls/certs/ca-bundle.crt
