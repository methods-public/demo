# dataloop_chef_client

[![Build Status](https://travis-ci.org/miroswan/dataloop_chef_client.svg?branch=master)](https://travis-ci.org/miroswan/dataloop_chef_client)
![Project Status](https://img.shields.io/badge/status-incubating-blue.svg)

This cookbook provides a dataloop plugin that monitors the last check-in time
from chef clients. Please note that it does *not* install dataloop. It does,
however, expect that dataloop is installed in order for its file-based plugin
deployment to work properly.

### Deployment
Simply add dataloop_chef_client the run-list. It will deploy a three resources:

* script: Executable file responsible for querying the ChefSever for the
ohai_time and writing plugin output to file (/var/opt/dataloop_chef_client.out
by default)
* plugin: Executable file resopnsible for reading the contents of the output
file to be interpreted by dataloop, stored by default in /opt/dataloop/plugins
* cron: Executes the script on a given interval

## Important attributes:

* default['dataloop-chef-client']['warning']: default 3600 seconds (1 hour)
* default['dataloop-chef-client']['critical']: default 86400 (1 day)

## Tested Operating Systems
* Ubuntu 12.04
* Ubuntu 14.04
* Centos 6.7
* Centos 7.2

## Tested Chef Clients
* 11.18.0
* 12.6.0

### Development
Be sure to have a docker instance running. docker-machine is a good way to
ensure this. Installation instructions can be found
[here](https://www.docker.com/docker-toolbox)

Next, execute the following in the root of this project:

```
docker-machine start
eval $(docker-machine env)
gem install bundler
bundle install
```

If all is well, you should have all dependencies installed. To test, simply
run rake. Integration tests are run under [test-kitchen](http://kitchen.ci/)
using the [kitchen-docker](https://github.com/portertech/kitchen-docker)
provider.

### Why a leverage a cron job?
The Chef-API needs read access to sensitive files, namely client.rb and
client.pem. Instead of granting the dataloop user access to these files, this
cookbook run the script under root and simply allows the dataloop user to read
the output of the script.
