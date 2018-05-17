default['yum']['elasticsearch']['description'] = 'Elasticsearch Repository'
default['yum']['elasticsearch']['baseurl'] = 'https://artifacts.elastic.co/packages/5.x/yum'
default['yum']['elasticsearch']['gpgkey'] = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
default['yum']['elasticsearch']['gpgcheck'] = true
default['yum']['elasticsearch']['enabled'] = true
default['yum']['elasticsearch']['managed'] = true

default['yum']['elasticsearch-curator']['description'] = 'Curator Repository'
default['yum']['elasticsearch-curator']['baseurl'] = "http://packages.elastic.co/curator/4/centos/#{node['platform_version'].to_i}"
default['yum']['elasticsearch-curator']['gpgkey'] = 'http://packages.elastic.co/GPG-KEY-elasticsearch'
default['yum']['elasticsearch-curator']['gpgcheck'] = true
default['yum']['elasticsearch-curator']['enabled'] = true
default['yum']['elasticsearch-curator']['managed'] = true
