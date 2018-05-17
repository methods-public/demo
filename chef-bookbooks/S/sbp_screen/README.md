sbp_screen Cookbook
===================
This cookbook will install and configure screen


Attributes
----------
All 'tunables' are optional. There are only a hand full in there now, so please just add them as you see fit and send a pull request to get them in here. Below are a couple of examples:

default['screen']['tunables']['termcap_xterm']     = 'is=\E[r\E[m\E[2J\E[H\E[?7h\E[?1;4;6l'
default['screen']['tunables']['terminfo_xterm']    = 'is=\E[r\E[m\E[2J\E[H\E[?7h\E[?1;4;6l'
default['screen']['tunables']['hardstatus']        = 'alwayslastline'


Usage
-----
Include `sbp_screen` in your node's `run_list`


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
Authors: Sander van Harmelen

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
