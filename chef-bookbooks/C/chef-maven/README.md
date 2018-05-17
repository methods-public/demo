# chef-maven Cookbook

[![Build Status](https://travis-ci.org/trueCii/chef-maven.svg?branch=master)](https://travis-ci.org/trueCii/chef-maven)

Installs and configures Apache Maven. This cookbook doesn't install Java. Make sure to install java for this cookbook to work properly. Look the public [Java Cookbook](https://supermarket.chef.io/cookbooks/java) for more details

## Requirements

Requires Java

### Platforms Supported

The following platforms have been tested with kitchen

- CentOS 6+
- Ubuntu 14.04+

### Chef

- Chef 12.1 or later

### Cookbooks

This cookbook is dependent on [tar](https://supermarket.chef.io/cookbooks/tar)

## Attributes

- ` node['maven']['version']` - specifies the version [Check for available versions](https://maven.apache.org/download.cgi)
- ` default['maven']['checksum']` - specifies the checksum for the tar file (shasum -a 256 filename)
- ` node['maven']['settings_file']` - maven settings.xml file. Override this attribute to use your custom file
- ` node['maven']['user']` - user that maven will run as
- ` node['maven']['group']` - group for maven
- ` node['maven']['dir_perm']` - permission for maven folder
- ` node['maven']['m2_home']` - defaults to /usr/local/apache-maven-#{node['maven']['version']}
- ` node['maven']['maven_opts']` - value of MAVEN_OPTS
- ` node['maven']['url']` - maven download url

## Usage

### chef-maven::install

Installs the specified version of maven `node['maven']['version']` at the specified home directory ` node['maven']['m2_home']`

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: trueCii
