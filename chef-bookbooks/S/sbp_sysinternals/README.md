sbp_sysinternals Cookbook
=========================
This cookbook will deploy the Sysinternals Suite and configure (if the correct attributes are set) BGInfo


Requirements
------------
The cookbook depends on the windows cookbook


Attributes
----------
The attribute default['sysinternals']['bginfo_config_url'] expects a download location for a zipfile containing the config.bgi. We choose this solution because
if we would include the config.bgi directly file in the cookbook, every user of the cookbook should have to either alter or wrap the cookbook in order to provide
his/her own version of the config.bgi file.

default['sysinternals']['url']               = 'http://download.sysinternals.com/files/SysinternalsSuite.zip'
default['sysinternals']['install_dir']       = "#{ENV['SYSTEMDRIVE']}\\SysinternalsSuite"
default['sysinternals']['bginfo_config_url'] = 'http://local_http_repo/BgInfo.zip'
default['sysinternals']['bginfo_config_dir'] = "#{ENV['SYSTEMDRIVE']}\\BgInfo"


Usage
-----
Just include `sbp_sysinternals` in your node's `run_list`


Contributing
------------
  1. Fork the repository on Github
  2. Create a named feature branch (i.e. `add-new-recipe`)
  3. Write you change
  4. Write tests for your change (if applicable)
  5. Run the tests, ensuring they all pass
  6. Submit a Pull Request


License and Authors
-------------------
Authors: Sander van Harmelen, Mark Reijn

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

