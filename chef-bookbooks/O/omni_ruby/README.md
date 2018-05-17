OmniRuby
=============

This cookbook provides Ruby installation from a variety of places. It also
handles ohai reloading to ensure proper ruby/gem usage.  It is forked and based
off of the ruby_installer cookbook, found at https://github.com/hw-cookbooks/ruby_installer

Usage
=====

```
knife node run_list add my.node recipe[omni_ruby]
```

By default it will install ruby packages and generally defaults to 1.8. You
can override that by providing the package names you want installed via
attributes.

Configurable attributes
=======================

* `default['omni_ruby']['method'] = 'package' # package/ree/source`
* `default['omni_ruby']['package_name'] = true # apt package name`
* `default['omni_ruby']['rubygem_package'] = true # install rubygems package`
* `default['omni_ruby']['rubydev_package'] = true # install ruby development libs`
* `default['omni_ruby']['source_version'] = nil # source version`
* `default['omni_ruby']['source_package_dependencies'] = [] # package dependencies for building from source`
* `default['omni_ruby']['ree_url'] = 'http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise_1.8.7-2012.02_amd64_ubuntu10.04.deb' # URI for REE deb package`
* `default['omni_ruby']['ree_source_url'] = 'http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2012.02.tar.gz' # URI for REE source`

Repository
==========

https://github.com/spindance-ops/omni_ruby

Contributors
============
* Erik Kranzusch - https://github.com/erikk-spindance
* Chris Roberts - https://github.com/chrisroberts
* Graham McIntire - https://github.com/gmcintire
