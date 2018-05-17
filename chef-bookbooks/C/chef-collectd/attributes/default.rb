#
# Collectd options
#
default['collectd']['user']  = 'collectd'
default['collectd']['group'] = 'daemon'
default['collectd']['dir']   = '/etc/collectd'

#
# Systemd unit
#
default['collectd']['systemd'] = {
  'Unit'    => { 'Description' => 'collectd daemon',
                 'After'       => 'local-fs.target network.target',
                 'Requires'    => 'local-fs.target network.target' },
  'Service' => { 'Type'         => 'notify',
                 'ExecStartPre' => "/usr/sbin/collectd -C #{node['collectd']['dir']}/collectd.conf -t",
                 'ExecStart'    => "/usr/sbin/collectd -C #{node['collectd']['dir']}/collectd.conf",
                 'Restart'      => 'on-failure',
                 'User'         => node['collectd']['user'] },
  'Install' => { 'WantedBy' => 'multi-user.target' },
}

#
# Configuration (must have at least one line)
#
default['collectd']['conf']['global']['FQDNLookup'] = true
