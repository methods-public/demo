default['fabio']['init_style']   = 'runit'
default['fabio']['open_files']   = 65535
default['fabio']['config']       = {}
default['fabio']['install_path'] = '/usr/local/bin/fabio'

default['fabio']['conf_dir']     = '/etc/fabio'
default['fabio']['log_dir']      = '/var/log/fabio'
default['fabio']['service_name'] = 'fabio'

# Installation source
default['fabio']['release_url']  = 'https://github.com/eBay/fabio/releases/download/v1.2/fabio-1.2-go1.6.3_linux-amd64'
default['fabio']['checksum']     = 'afe7ca51bb390867f936aa03e89f9311143cf6fc5477da270676bf472434cfda'
