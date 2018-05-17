default['tideways']['yum_url'] = 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/rpm'
default['tideways']['apt_url'] = 'http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages'
default['tideways']['gpgkey'] = 'https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg'

default['tideways']['ini_file'] = if platform_family?('rhel', 'fedora')
                                    '40-tideways.ini'
                                  else
                                    'tideways.ini'
                                  end

default['tideways']['php_service_name'] = 'php-fpm'

default['tideways']['api_key'] = nil
default['tideways']['framework'] = nil

default['tideways']['auto_start'] = 'Yes'
default['tideways']['auto_prepend_library'] = 'Yes'
