# frozen_string_literal: true

name 'docker-machine'
maintainer 'byplayer'
maintainer_email 'byplayer100@gmail.com'
license 'Apache v2.0'
description 'Installs/Configures docker-machine'
long_description 'Installs/Configures docker-machine'
%w[centos ubuntu].each do |os|
  supports os
end
version '1.0.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
source_url 'https://github.com/byplayer/chef-cookbook-docker-machine'
