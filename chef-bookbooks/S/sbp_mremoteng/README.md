sbp_mremoteng Cookbook
======================
This cookbook will install mRemoteNG on a Windows box and will (optionally) generate the mRemoteNG config based on all available nodes in your Chef server.


Requirements
------------
The cookbook depends on the windows and partial_search cookbooks


Attributes
----------
When default['mremoteng']['shared_config_dir'] is set to `nil` the cookbook will not create a confCons.xml for you. When this is set to a path, it will generate a config and update the mRemoteNG config so it uses the generated configuration.

default['mremoteng']['package_name']      = 'mRemoteNG'
default['mremoteng']['install_dir']       = 'C:\Program Files (x86)\mRemoteNG'
default['mremoteng']['version']           = '1.74.6023.15437'
default['mremoteng']['url']               = 'https://github.com/mRemoteNG/mRemoteNG/releases/download/v1.74/mRemoteNG-Installer-1.74.6023.15437.msi'
default['mremoteng']['checksum']          = '2d637780be5875221448dc259ce8ae8f5f9fc95adc87a2571610e305826df6a3'
default['mremoteng']['shared_config_dir'] = nil
default['mremoteng']['auto_expand']       = 'True'


Usage
-----
Just include `sbp_mremoteng` in your node's `run_list`


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
Authors: Sander van Harmelen, Ane van Straten

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
