Description
===========

Installs or compiles/installs fish-shell; a command line shell for the 90s

Requirements
============

## Platform:

* FreeBSD
* Red Hat/CentOS/Fedora/Scientific
* ArchLinux

Attributes
==========

## Default recipe attributes:

* `node['fish-shell']['extra_packages']` - An array of extra packages related to vim to install (like plugins). Empty array by default.

* `node['fish-shell']['install_method']` - Sets the install method, choose from the various install recipes. This attribute is set to 'package' by default.


## Source recipe attributes:

* `node['fish-shell']['source']['version']` -  The version of fish-shell to compile, 2.1.2 by default.
* `node['fish-shell']['source']['checksum']` -  The source file checksum.


Usage
=====

Put `recipe[fish-shell]` in a run list, or `include_recipe 'fish-shell'` to ensure that fish is installed on your systems.

License and Author
==================

Author:: David tBunnyMan Aronsohn <tbunnyman@me.com>

```text
Copyright (c) 2015 ChefFurs
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
