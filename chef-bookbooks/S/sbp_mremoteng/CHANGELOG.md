sbp_mremoteng CHANGELOG
=======================

0.2.3
----
- Joris van Lieshout - The code that builds the node list for the template was using a regular search which retreives all node objects and is therefore slow. Using partial_search instead speeds up the recipe quite a bit 

0.2.2
-----
- Create the shared config directory with recursive set to true to prevent errors with nested directories

0.1.0
-----
- Sander van Harmelen / Ane van Straten - Initial release of mremoteng
