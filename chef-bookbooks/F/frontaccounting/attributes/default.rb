#
# Cookbook Name:: frontaccounting
# Attributes:: default
#
# Copyright 2014-2015, North County Tech Center, LLC
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

default['frontaccounting']['version'] = '2.3'
default['frontaccounting']['minorversion'] = '2.3'
# the download URL should always point to the tar.gz file, not the zip file
default['frontaccounting']['downloadurl'] = 'http://sourceforge.net/projects/frontaccounting/files/FrontAccounting-2.3/2.3.22/frontaccounting-2.3.22.tar.gz/download'

# Under which url on the Web server should frontaccounting be accessed?
default['frontaccounting']['baseurl'] = '/accounting'
# Where should the files be stored (the baseurl will be added, so the default
# actual documentroot will be /var/www/html/accounting
default['frontaccounting']['documentroot'] = '/var/www/html'
# The server name, in case accounting needs to run on a virtual server
default['frontaccounting']['servername'] = node['fqdn']
default['frontaccounting']['fileuser'] = 'root'
default['frontaccounting']['filegroup'] = 'apache'

default['frontaccounting']['company']['companyname'] = 'Sample Company, Inc.'
default['frontaccounting']['company']['dbhost'] = 'localhost'
default['frontaccounting']['company']['dbname'] = 'frontacc'
default['frontaccounting']['company']['dbuser'] = 'frontacc'

default['frontaccounting']['lang']['C']['name'] = "US English"
default['frontaccounting']['lang']['C']['encoding'] = "iso-8859-1"

# Frontaccounting needs to connect to install extensions/coas/languages etc.,
# and also to connect to a remote MySQL server.
override['selinux']['booleans']['httpd_can_network_connect'] = "on"
override['selinux']['booleans']['httpd_can_network_connect_db'] = "on"

