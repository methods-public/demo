name 'yum_repositories'
maintainer 'Alex Markessinis'
maintainer_email 'markea125@gmail.com'
license 'MIT'
description 'Cookbook that wraps the yum_repository resource allowing one to define repositories in attributes.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.1'
%w( redhat centos fedora amazon ).each do |os|
  supports os
end
chef_version '>= 12.14' if respond_to?(:chef_version)
issues_url 'https://github.com/MelonSmasher/chef_yum_repositories/issues' if respond_to?(:issues_url)
source_url 'https://github.com/MelonSmasher/chef_yum_repositories' if respond_to?(:source_url)
