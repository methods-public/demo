node.default['php']['package_version'] = 'php71u'

node.default['php']['packages'] = [
  "#{node['php']['package_version']}-cli",
  "#{node['php']['package_version']}-intl",
  "#{node['php']['package_version']}-curl",
  "#{node['php']['package_version']}-mbstring",
  "#{node['php']['package_version']}-json",
  "#{node['php']['package_version']}-opcache",
  "#{node['php']['package_version']}-xml",
]

node.default['php']['directives'] = {
  'expose_php' => 0,
  'memory_limit' => -1,
  'max_execution_time' => 5,

  'realpath_cache_size' => '4096k',
  'realpath_cache_ttl' => 7200,

  'error_log' => 'syslog',
  'serialize_precision' => '-1',
}

include_recipe 'php::package'

# Pear must be installed after PHP, however this functions for all versions of PHP
package 'pear1u'

node.default['php']['opcache-directives'] = {
  'opcache.fast_shutdown' => 1,
  'opcache.enable_cli' => 0,

  'opcache.memory_consumption' => 256,
  'opcache.interned_strings_buffer' => 64,
  'opcache.max_accelerated_files' => 25000,
}

# Opcache settings need to be stored saved in /etc/php.d/ due to system defaults in 10-opcache
file '/etc/php.d/zz-opcache.ini' do
  content node['php']['opcache-directives'].map { |k, v| "#{k}=#{v}" }.join("\n")
  mode '0664'
end
