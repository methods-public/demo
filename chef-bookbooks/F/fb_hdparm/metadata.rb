# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
name 'fb_hdparm'
maintainer 'Facebook'
maintainer_email 'noreply@facebook.com'
license 'BSD-3-Clause'
source_url 'https://github.com/facebook/chef-cookbooks/'
description 'Installs/Configures hdparm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
supports 'centos'
supports 'debian'
supports 'ubuntu'
depends 'fb_helpers'
