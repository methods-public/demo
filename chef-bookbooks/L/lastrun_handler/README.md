# chef-lastrun_handler [![Build Status](https://secure.travis-ci.org/bflad/chef-lastrun_handler.png?branch=master)](http://travis-ci.org/bflad/chef-lastrun_handler)

## Description

Chef cookbook that installs and enables lastrun handler for
[knife-lastrun](https://github.com/jgoulah/knife-lastrun)

## Requirements

### Platforms

* RedHat 6.3 (Santiago)
* Ubuntu 12.04 (Precise)

### Cookbooks

* chef_handler

## Attributes

None

## Recipes

* `recipe[lastrun_handler]` will install and enable lastrun handler.

## Usage

* Add `recipe[lastrun_handler]` to your node's run list
* After a Chef client run, use knife-lastrun to check information

### Using with whitelist-node-attrs

Since the whitelist cookbook will override node.save, you need to ensure it has
the `node['lastrun']` and `node['whitelist']` attributes saved. For example:
    
    "whitelist" => {
      "lastrun" => true,
      "whitelist" => true
    }
    
## Contributing

Please use standard Github issues/pull requests.

## License and Author
      
Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
