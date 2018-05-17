Testing the chef-maven cookbook
=====

This cookbook includes integration tests via [inspec](https://www.inspec.io/) and [Kitchen](https://kitchen.ci/).

```bash
kitchen test
```

Testing Prerequisites
-----

A working ChefDK installation. Chef Development Kit (ChefDK) brings Chef and the development tools developed by the Chef Community. Get the latest version here [->](http://downloads.getchef.com/chef-dk/)

Install the latest version of [Vagrant](http://www.vagrantup.com/downloads.html).

Clone the latest version of the cookbook from the repository.

```bash
git clone https://github.com/trueCii/chef-maven.git
cd chef-maven
```

Running Test Kitchen
-----
Inspec tests are located at [test/integration/default/inspec/default.rb](https://github.com/trueCii/chef-maven/blob/master/test/integration/default/inspec/default.rb)
Test suites are defined in [.kitchen.yml](https://github.com/trueCii/chef-maven/blob/master/.kitchen.yml). Running `kitchen test` will cause Test Kitchen to spin up each platform VM in turn, running the `chef-maven::default` recipe and installing maven on it. If the Chef run completes successfully, corresponding tests in `test/integration` are executed. These must also pass.
