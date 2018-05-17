# yum-jenkins cookbook
[![Build Status](https://img.shields.io/travis/johnbellone/yum-jenkins-cookbook.svg)](https://travis-ci.org/johnbellone/yum-jenkins-cookbook)
[![Code Quality](https://img.shields.io/codeclimate/github/johnbellone/yum-jenkins-cookbook.svg)](https://codeclimate.com/github/johnbellone/yum-jenkins-cookbook)
[![Cookbook Version](https://img.shields.io/cookbook/v/yum-jenkins.svg)](https://supermarket.chef.io/cookbooks/yum-jenkins)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

The yum-jenkins cookbook installs the Jenkins Yum repository.

## Basic Usage
The Yum repository will automatically be configured by simply including
the [default recipe](recipes/default.rb) in the node's run-list. To disable
the repository set the appropriate attribute:
``` ruby
node.default['yum']['jenkins']['enabled'] = false
```

[1]: https://en.wikipedia.org/wiki/.properties
[2]: https://maven.apache.org/plugins/maven-dependency-plugin/
