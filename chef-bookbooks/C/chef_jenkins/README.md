# chef_jenkins

[![Build Status](https://travis-ci.org/ndobson/chef_jenkins.svg?branch=master)](https://travis-ci.org/ndobson/chef_jenkins) [![Cookbook Version](https://img.shields.io/cookbook/v/chef_jenkins.svg)](https://supermarket.chef.io/cookbooks/chef_jenkins)

This cookbook extends the already awesome [Jenkins cookbook](https://supermarket.chef.io/cookbooks/jenkins) to provide a set of resources to make Jenkins job generating a little more painless,
heavily leverages [templates](https://docs.chef.io/resource_template.html) and [partial templates](https://docs.chef.io/resource_template.html#partial-templates).

## Requirements

### Platforms

- Debian/Ubuntu
- RHEL/CentOS/Scientific/Amazon/Oracle

### Chef

- Chef 12.5+

### Cookbooks

- jenkins

## Examples

The tests and fixture cookbooks in `tests` and `tests/fixtures` are intended to be a further source of examples.

## Resource/Provider
All resources support auto-generation of nested folders.

### chef_jenkins_folder
This resource creates one or more folder items in Jenkins. Requires the [CloudBees Folders](https://wiki.jenkins-ci.org/display/JENKINS/CloudBees+Folders+Plugin) plugin to be installed.

### chef_jenkins_freestyle
This resource creates a Jenkins freestyle job.

### chef_jenkins_pipeline
This resource creates a [Jenkins Pipeline](https://jenkins.io/doc/book/pipeline/) job. Requires the [Pipeline](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin) plugin and it's dependencies to be installed.

### chef_jenkins_github_org
This resource creates a Jenkins Github organization job. Requires the [Pipeline](https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Branch+Source+Plugin) plugin and it's dependencies to be installed.

### chef_jenkins_multibranch_pipeline
This resource creates a [Jenkins Multibranch Pipeline](https://jenkins.io/doc/book/pipeline/multibranch/) job. Requires the [GitHub Branch Source](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin) plugin and it's dependencies to be installed.
