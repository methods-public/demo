name 'file-vault'
maintainer 'Stanislav Bogatyev'
maintainer_email 'realloc@realloc.spb.ru'
license 'Apache 2.0'
description 'Get secret files from chef-vault!'
long_description 'Get secret files from chef-vault!'
version '0.0.2'
source_url 'https://github.com/realloc/cookbook-file-vault'
issues_url 'https://github.com/realloc/cookbook-file-vault/issues'

%w(ubuntu debian redhat centos fedora).each do |os|
  supports os
end

depends 'chef-vault', '~> 1.0.4'
