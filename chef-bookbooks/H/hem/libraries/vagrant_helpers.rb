require 'uri'
require 'open-uri'

def vagrant_base_uri
  'https://releases.hashicorp.com/vagrant/'
end

def vagrant_release_directory(vers)
  "#{vagrant_base_uri}#{vers}"
end

def vagrant_sha256sum(vers = nil)
  sha256sums = open("#{vagrant_release_directory(vers)}/vagrant_#{vers}_SHA256SUMS?direct")
  sha256sums.readlines.grep(/#{vagrant_platform_package(vers)}/)[0].split.first
end

def vagrant_package_uri(vers = nil)
  "#{vagrant_release_directory(vers)}/#{vagrant_platform_package(vers)}"
end
