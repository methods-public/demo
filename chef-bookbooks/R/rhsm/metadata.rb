name             'rhsm'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Provides recipes to manage registration using RedHat Subscription Manager'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

supports 'redhat'

depends 'chef-sugar'

recipe 'rhsm::default', 'Register instance and add code to unregister at shutdown'
recipe 'rhsm::register', 'Register instance'
recipe 'rhsm::unregister', 'Unregister instance'

attribute 'rhsm/username',
  :display_name => 'RedHat Account Username',
  :description => 'RedHat Account Username',
  :required => 'optional',
  :recipes => ['rhsm::default', 'rhsm::register']

attribute 'rhsm/password',
  :display_name => 'RedHat Account Password',
  :description => 'RedHat Account Password',
  :required => 'optional',
  :recipes => ['rhsm::default', 'rhsm::register']

attribute 'rhsm/additional_repos',
  :display_name => 'Additional RHEL Repos',
  :description => 'Additional RHEL repos to enabled',
  :required => 'optional',
  :type => 'array',
  :default => [],
  :recipes => ['rhsm::default', 'rhsm::register']
