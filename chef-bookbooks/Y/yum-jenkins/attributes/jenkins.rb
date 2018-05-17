#
# Cookbook: yum-jenkins
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#
default['yum']['jenkins']['repositoryid'] = 'jenkins'
default['yum']['jenkins']['baseurl'] = 'http://pkg.jenkins-ci.org/redhat'
default['yum']['jenkins']['description'] = 'Enterprise Linux RPM packages for Jenkins.'
default['yum']['jenkins']['gpgkey'] = 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key'
default['yum']['jenkins']['gpgcheck'] = true
default['yum']['jenkins']['managed'] = true
default['yum']['jenkins']['enabled'] = true
