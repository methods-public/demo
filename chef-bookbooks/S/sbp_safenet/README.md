sbp_safenet Cookbook
====================
This cookbook will install SafeNet Client on Windows


Requirements
------------
The cookbook depends on the windows cookbook


Attributes
----------
default['safenet']['package_name']  = 'SafeNet Authentication Client 8.2'
default['safenet']['url']          	= ''

The package to use is 'SafeNetAuthenticationClient-eToken-x64-8.2.msi', and is stored on a local repo.


Usage
-----
Just put 'sbp_safenet' in your run-list


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
