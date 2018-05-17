name 'metasploit'
maintainer 'Sahed Salam'
maintainer_email 'salamsahed@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures metasploit'
long_description 'Installs/Configures metasploit'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

supports 'ubuntu'
supports 'centos'
supports 'redhat'
supports 'debian'
supports 'solaris'
supports 'opensuse'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/shalamus/metasploit/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/shalamus/metasploit'
