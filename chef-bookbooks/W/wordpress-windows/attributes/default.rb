# attributes

default['wordpress']['version'] = "latest"
default['wordpress']['checksum'] = ""

default['wordpress']['windows']['path']['cache']="C:\\chef\\cache\\wordpress-temp"
default['wordpress']['windows']['path']['extract']="#{node['wordpress']['windows']['path']['cache']}\\wordpress"
default['wordpress']['windows']['path']['install']="#{node['apache2']['windows']['path'].gsub('\\', '/')}/htdocs"
default['wordpress']['windows']['path']['admin']="#{node['wordpress']['windows']['path']['install']}/wp-admin"
default['wordpress']['database']['hostname']="wordpress"

default['wordpress']['windows']['siteurl']="http://#{node["azurefqdn"].downcase}/"

default['wordpress']['windows']['plugins']['path']="#{node['wordpress']['windows']['path']['install']}/wp-content/plugins"

default['wordpress']['cli']['path']="#{Chef::Config[:file_cache_path]}/wp-cli"
default['wordpress']['cli']['source']='http://wp-cli.org/packages/phar/wp-cli.phar'
default['wordpress']['cli']['checksum']='13f06357ba1576f2d644cd1545aa7b805d10ddad2f7b7dfa89eb5ba1407b7def'

