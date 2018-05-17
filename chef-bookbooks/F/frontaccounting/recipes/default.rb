#
# Cookbook Name:: frontaccounting
# Recipe:: default
#
# Copyright (C) 2014-2015 North County Tech Center, LLC
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

include_recipe "php"
package "php-mysql"

mysql_client 'default' do
  action :create
end

downloadurl=node['frontaccounting']['downloadurl']
version=node['frontaccounting']['version']
minorversion=node['frontaccounting']['minorversion']
downloadfile="frontaccounting-#{version}.#{minorversion}.tar.gz"

baseurl=node['frontaccounting']['baseurl']
documentroot=node['frontaccounting']['documentroot']
basedir="#{documentroot}#{baseurl}"
fileuser=node['frontaccounting']['fileuser']
filegroup=node['frontaccounting']['filegroup']

# If SELinux is enabled, Apache needs to be allowed to send emails.
node.set['selinux']['booleans']["httpd_can_sendmail"] = "on"

directory basedir do
  recursive true
end

fqdn = node['frontaccounting']['servername']

remote_file "#{Chef::Config[:file_cache_path]}/#{downloadfile}" do
  action :create_if_missing
  source downloadurl
  backup 0
end

bash "unpack frontaccounting" do
  action :run
  code "
tar xfz #{Chef::Config[:file_cache_path]}/#{downloadfile} -C #{basedir} --strip-components=1
chown -R #{fileuser}:#{filegroup} #{basedir}
"
  not_if {File.exists?("#{basedir}/index.php")}
end

# Clean up a few files and directories that are not needed and might constitute security
# concerns.
%w{ install.html update.html config.default.php }.each do |f|
  file "#{basedir}/#{f}" do
    action :delete
  end
end

# The install directory must be deleted for security reasons.
# It is not needed because this cookbook does the same things as
# the install wizard would ordinarily do
directory "#{basedir}/install" do
  action :delete
  recursive true
end

# Configure FrontAccounting. Once these files are created, don't touch them
# because FrontAccounting may have updated them.
password = node.run_state[:frontaccounting_dbpw]

defaultcompany = {}
%w{ companyname dbhost dbname dbuser }.each do |attrname|
  defaultcompany[attrname] = node['frontaccounting']['company'][attrname]
end
defaultcompany['dbpassword'] = password

# Create the database for company 0
# This is not by itself idempotent, but triggered by a notifies to
# avoid overwriting an existing database.
bash "import frontaccounting database" do
  action :nothing
  code "mysql -h #{defaultcompany['dbhost']} -u #{defaultcompany['dbuser']} '--password=#{defaultcompany['dbpassword']}' #{defaultcompany['dbname']} < #{basedir}/sql/en_US-demo.sql
"
end

#############################################################
# Initial setup of the various configuration files.
# IMPORTANT: always use action create_if_missing since
# FrontAccounting will later update most of these files
# with new information!
#
%w{ 0 0/images 0/pdf_files 0/backup 0/js_cache}.each do |csubdir|
  directory "#{basedir}/company/#{csubdir}" do
    owner fileuser
    group filegroup
    mode  "0770"
  end
end

# Files with permission 440
%w{ config.php }.each do |f|
  template "#{basedir}/#{f}" do
    action :create_if_missing
    source "#{f}.erb"
    owner fileuser
    group filegroup
    mode  "0440"
  end
end

# Files with permission 660
%w{ installed_extensions.php company/0/installed_extensions.php lang/installed_languages.inc config_db.php }.each do |f|
  fname = File.basename(f)
  template "#{basedir}/#{f}" do
    action :create_if_missing
    source "#{fname}.erb"
    owner fileuser
    group filegroup
    mode  "0660"
    variables(
      :companydata => defaultcompany,
      :languages => node['frontaccounting']['lang']
    )
    notifies :run, "bash[import frontaccounting database]", :immediate
  end
end

file "#{basedir}/tmp/faillog.php" do
  action :create_if_missing
  owner fileuser
  group filegroup
  mode  "0660"
end

