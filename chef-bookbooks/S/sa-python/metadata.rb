name 'sa-python'
maintainer 'Vyacheslav Voronenko'
maintainer_email 'git@voronenko.info'
license 'MIT'
description 'Installs/Configures pip, virtualenv, virtualenvwrapper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.3'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
issues_url 'https://github.com/softasap/sa-python-chef/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
source_url 'https://github.com/softasap/sa-python-chef' if respond_to?(:source_url)

supports 'ubuntu', '>= 14.04'
supports 'centos', '>= 6.8'
