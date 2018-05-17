default['graphite_influxdb']['install_method'] = 'git'
default['graphite_influxdb']['git']['install_repo'] = 'https://github.com/vimeo/graphite-influxdb.git'
default['graphite_influxdb']['git']['install_hash'] = 'e4221493d1668b7d28ae9ca675e13c547653e6d2'
default['graphite_influxdb']['git']['clone_directory'] = '/opt/graphite_influxdb'

default['graphite_api']['cache'] = {
    'enabled' => true,
    'type' => 'filesystem',
    'dir' => '/tmp/graphite-api-cache',
}

default['graphite_influxdb']['influxdb'] = {
    'enabled' => true,
    'host' => 'localhost',
    'port' => '8086',
    'user' => 'graphite',
    'pass' => 'graphite',
    'db'   => 'graphite',
    'ssl'  => 'false',
    'schema' => [
        ['high-res-metrics', 1],
        ['^collectd', 10]
    ]
}

if node['graphite_influxdb']['influxdb']['enabled'] == true
    default['graphite_api']['finders'] |= ['graphite_influxdb.InfluxdbFinder']
end
