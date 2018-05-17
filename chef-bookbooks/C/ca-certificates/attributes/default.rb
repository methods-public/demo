case node['platform_family']
when 'rhel'
  default['ca-certificates']['ca-bundle_file'] = '/etc/pki/tls/certs/ca-bundle.crt'
  default['ca-certificates']['certificates_directory'] = '/etc/pki/ca-trust/source/anchors'
  default['ca-certificates']['update_command'] = '/usr/bin/update-ca-trust force-enable; /usr/bin/update-ca-trust extract'
  default['ca-certificates']['owner'] = 'root'
  default['ca-certificates']['group'] = 'root'
  case node['platform_version'].to_i
  when 5
    default['ca-certificates']['package'] = 'openssl'
    default['ca-certificates']['update-ca-trust'] = false
  when 6
    default['ca-certificates']['package'] = 'ca-certificates'
    default['ca-certificates']['update-ca-trust'] = true
  when 7
    default['ca-certificates']['package'] = 'ca-certificates'
    default['ca-certificates']['update-ca-trust'] = true
  else
    default['ca-certificates']['package'] = 'ca-certificates'
    default['ca-certificates']['update-ca-trust'] = true
    end
when 'debian'
  default['ca-certificates']['ca-bundle_file'] = '/etc/ssl/certs/ca-certificates.crt'
  default['ca-certificates']['package'] = 'ca-certificates'
  default['ca-certificates']['certificates_directory'] = '/usr/local/share/ca-certificates'
  default['ca-certificates']['update-ca-trust'] = true
  default['ca-certificates']['update_command'] = '/usr/sbin/update-ca-certificates'
  default['ca-certificates']['owner'] = 'root'
  default['ca-certificates']['group'] = 'staff'
else
  default['ca-certificates']['package'] = 'ca-certificates'
  default['ca-certificates']['update-ca-trust'] = false
  default['ca-certificates']['ca-bundle_file'] = '/etc/pki/tls/certs/ca-bundle.crt'
  default['ca-certificates']['owner'] = 'root'
  default['ca-certificates']['group'] = 'root'
end
