include_attribute "apache2-windows"

default['php']['windows']['source'] = "http://windows.php.net/downloads/releases/archives/php-5.4.13-Win32-VC9-x86.zip"
default['php']['windows']['checksum'] = "0684359738ae839984d52ef41c6cde4cd8d7a65a"
default['php']['windows']['drive'] = "C:"
default['php']['windows']['directory'] = "PHP"
default['php']['windows']['path'] = "#{node['php']['windows']['drive']}\\#{node['php']['windows']['directory']}"

# loop through this in template for php.ini
default['php']['extension']['init']=['php_mysql.dll']
# FIXME: these attributes should be related to what is actually installed
#,'php_pdo_sqlsrv_54_ts.dll','php_sqlsrv_54_ts.dll']
