
default['java']['jdk_version'] = 7
default['openfire']['version'] = '4.0.3'

# rubocop:disable LineLength
default['openfire']['checksum']['4.0.3']['deb'] = '2b34ec323d8aed52802b4f846624b645653a0044d0b9705b64494d0c30c2f71a'
default['openfire']['checksum']['4.0.3']['rpm'] = 'c76a92cbea5a1ef12552e49362e5cedb068eccdb0f8f7fe7481c3fc23cd29210'
default['openfire']['checksum']['4.0.3']['exe'] = 'bc860596c3db9bf0472199866244977a53f6d9b30a554195f504ef7b20ddc29d'

default['openfire']['base_dir'] = '/opt'
default['openfire']['home_dir'] = "#{node['openfire']['base_dir']}/openfire"
default['openfire']['log_dir']  = "#{node['openfire']['base_dir']}/openfire/logs"

default['openfire']['config']['admin_port'] = 9090
default['openfire']['config']['secure_port'] = 9091
default['openfire']['config']['locale'] = 'en'

default['openfire']['config']['database']['type'] = 'internal' # By default use internal database
default['openfire']['config']['database']['driver'] = 'org.postgresql.Driver'
default['openfire']['config']['database']['connection'] = 'jdbc:postgresql://127.0.0.1:5432/openfire'
default['openfire']['config']['database']['user'] = 'b1caec60e675b3741d7f4e7e5e1f4e988479eb9e82b92237'
default['openfire']['config']['database']['password'] = '20b2cf7bda516757a192e3c30114e8245f99e22f64af9dae89cdc6ca3c92399b5bb7bfba1b537bed153f010a1bdca89c'
# rubocop:enable LineLength
