sbp_baremetalsoft Cookbook
==========================
This cookbook will deploy the baretail and baregrep tools to a Windows system


Attributes
----------
default['baremetalsoft']['url']           = ''
default['baremetalsoft']['install_dir']   = 'C:\Program Files\BareMetalSoft'


Usage
-----
Just include `sbp_baremetalsoft` in your node's `run_list`


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
