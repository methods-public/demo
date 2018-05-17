default['stenographer']['threads'] = [
  { 'packets_dir' => '/data/stenographer/thread0/packets',
    'index_dir' => '/data/stenographer/thread0/index' }
]
default['stenographer']['mon_interface'] = 'enp0s3'
default['stenographer']['listen_port'] = 1234
default['stenographer']['listen_ip'] = '127.0.0.1'

default['stenographer']['user'] = 'stenographer'
default['stenographer']['group'] = 'stenographer'
