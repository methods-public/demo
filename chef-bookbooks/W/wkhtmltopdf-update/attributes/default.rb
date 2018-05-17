# Used for uninstalling old recipe for wkhtmltopdf
default['wkhtmltopdf']['version']     = '0.12.0'
default['wkhtmltopdf']['install_dir'] = '/usr/local/bin'
default['wkhtmltopdf']['lib_dir']     = ''

default['wkhtmltopdf-update']['install_dir'] = '/usr/local/bin'
default['wkhtmltopdf-update']['lib_dir']     = ''
default['wkhtmltopdf-update']['version'] = '0.12.4'

case node['platform_family']
when 'mac_os_x', 'mac_os_x_server'
  default['wkhtmltopdf-update']['dependency_packages'] = []
  default['wkhtmltopdf-update']['platform'] = 'osx-cocoa-x86-64.pkg'
when 'windows'
  default['wkhtmltopdf-update']['dependency_packages'] = []
  default['wkhtmltopdf-update']['platform'] = if node['kernel']['machine'] == 'x86_64'
                                                'msvc2015-win64.exe'
                                              else
                                                'msvc2015-win32.exe'
                                              end
else
  default['wkhtmltopdf-update']['dependency_packages'] = value_for_platform_family(
    %w[debian] => %w[zlib1g-dev libfontconfig1 libfreetype6-dev libxext6 libx11-dev libxrender1 fontconfig libjpeg8 xfonts-base xfonts-75dpi],
    %w[fedora rhel] => %w[fontconfig libXext libXrender openssl-devel urw-fonts]
  )
  default['wkhtmltopdf-update']['platform'] = if node['kernel']['machine'] == 'x86_64'
                                                'linux-generic-amd64.tar.xz'
                                              else
                                                'linux-generic-i386.tar.xz'
                                              end
end

default['wkhtmltopdf-update']['archive'] = "wkhtmltox-#{node['wkhtmltopdf-update']['version']}_#{node['wkhtmltopdf-update']['platform']}"
default['wkhtmltopdf-update']['mirror_url'] = "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/#{node['wkhtmltopdf-update']['version']}/#{node['wkhtmltopdf-update']['archive']}"

