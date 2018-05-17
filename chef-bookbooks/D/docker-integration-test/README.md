Cookbook - docker-integration-test
==================================
[![Chef cookbook](https://img.shields.io/cookbook/v/docker-integration-test.svg?style=flat)][cookbook]
[![Travis](https://img.shields.io/travis/4-20ma/cookbook-docker-integration-test.svg?style=flat)][travis]
[![Gemnasium](http://img.shields.io/gemnasium/4-20ma/cookbook-docker-integration-test.svg?style=flat)][gemnasium]

[cookbook]:   https://supermarket.chef.io/cookbooks/docker-integration-test
[travis]:     https://travis-ci.org/4-20ma/cookbook-docker-integration-test
[gemnasium]:  https://gemnasium.com/4-20ma/cookbook-docker-integration-test


Configuration
-------------

- macOS Sierra version 10.12.3
- Docker version 1.13.1, build 092cba3 (Mac app 1.13.1-beta42)
- Ruby 2.3.1 (via rbenv)


Setup
-----

Install gem dependencies (first run only):

    $ gem install bundler # if not already installed
    $ bundle

Update cookbook dependencies (first run only):

    $ berks
    Resolving cookbook dependencies...
    Fetching 'docker-integration-test' from source at .
    Using docker-integration-test (0.1.0) from source at .

Ensure kitchen is able to create the container (first run only):

    $ bundle exec kitchen create
    -----> Starting Kitchen (v1.7.3)
    -----> Creating <docker-integration-test-centos>...
           0.0.0.0:32781
           [SSH] Established
           Finished creating <docker-integration-test-centos> (0m4.35s).
    -----> Kitchen is finished. (0m4.71s)

Ensure kitchen is able to converge the cookbook (first run only):

    $ bundle exec kitchen converge
    -----> Starting Kitchen (v1.7.3)
    -----> Converging <docker-integration-test-centos>...
    $$$$$$ Running legacy converge for 'Docker' Driver
           Preparing files for transfer
           Preparing dna.json
           Resolving cookbook dependencies with Berkshelf 4.3.2...
           Removing non-cookbook files before transfer
           Preparing solo.rb
    -----> Chef Omnibus installation detected (install only if missing)
           Transferring files to <docker-integration-test-centos>
           Starting Chef Client, version 12.9.38
           [2016-05-01T19:11:31+00:00] WARN: unable to detect ipaddress
           Installing Cookbook Gems:
           Compiling Cookbooks...
           Converging 1 resources
           Recipe: docker-integration-test::default
             * file[/tmp/quick_brown_fox.txt] action create (up to date)
       
           Running handlers:
           Running handlers complete
           Chef Client finished, 0/1 resources updated in 01 seconds
           Finished converging <docker-integration-test-centos> (0m2.80s).
    -----> Kitchen is finished. (0m3.14s)

Run tests:

    $ bundle exec rake
    $ bundle exec rake integration


License & Authors
-----------------
- Author:: Doc Walker (<4-20ma@wvfans.net>)

````text
Copyright 2016-2017, Doc Walker

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
````
