require 'chef'

module Couch
  module Helpers
    def local_ini_file
      ini_file = '/etc/couchdb/local.ini'
      if new_resource.from_package
        return ini_file
      else
        return ::File.join(new_resource.path_prefix, ini_file)
      end
    end

    def local_ini_dir(service_resource)
      dir = '/etc/couchdb/local.d'
      if service_resource.from_package
        return dir
      else
        return ::File.join(service_resource.path_prefix, dir)
      end
    end

    def couch_package
      case node['platform_family']
      when 'debian'
        'couchdb'
      when 'fedora'
        'couchdb'
      end
    end

    def dev_packages
      pkgs = %w( gcc )
      case node['platform_family']
      when 'debian'
        pkgs += %w( libicu-dev libcurl4-openssl-dev g++ )
        pkgs << value_for_platform(
          'debian' => { 'default' => 'libmozjs-dev' },
          'ubuntu' => {
            '10.04' => 'xulrunner-dev',
            '14.04' => 'libmozjs185-dev',
            'default' => 'libmozjs-dev'
          })
      when 'rhel', 'fedora'
        pkgs += %w(
          gcc-c++
          which
          make
          js-devel
          libtool
          libicu-devel
          openssl-devel
          curl-devel
        )
      else
        Chef::Log.warn('Using unsupported platform family')
      end

      pkgs
    end
  end
end
