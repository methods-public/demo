Description
===========

Installs and configures Visual Studio 2008 + SP1. 

This includes all features of Visual Studio 2008 including the 64-bit C++ compiler. The default Visual Studio 2008 installer does not enable the 64-bit C++ compiler installation. The "/full" option used here would enable 64-bit compile to install. No Documentation is installed. 

For some reason, the custom INI file for the silent install fails to launch on Windows 8.1/Server 2012 R2 due to dependencies. However, it launches fine if we don't use an INI file and use the "/full" option. :(

I added a registry key to disable the Windows compatibility popup for SQL 2005 install since it is not supported on Windows 8.1/Server 2012 R2. 

Our purpose was to run server configuration automation inside a corporate firewall with no internet connection for security reason. :( 

Please see usage below for more details.

This takes about 35 minutes to run on my machine since it downloads the ISO, unzips it to a local path and then runs the install. The ISOs are immediately deleted after a successful run. I tried running mount-diskimage for the ISO (available in Windows 8.1/2012 R2 or newer) to save time from the unzip proces. However, it kept crashing on dismount-diskimage of the ISO in order for me to delete it. :(


Requirements
============

Platform
--------

* Windows with Chef client 11.14.2

Tested on:

* Windows Server 2012 R2
* Windows 8.1

Cookbooks
---------

* Windows
* 7-zip
* ms_dotnet35 (.net 3.5 must be enabled on Windows 8.1/2012 R2)

Resources and Providers
=======================

<Any Resources Or Providers Here>

Attributes
==========

* node['vs-2008']['base-network-location']    = 'http://my-iis-redirect-server/visual-studio'
* node['vs-2008']['preserve_iso_file'] = true  #keeps the ISOs after installation. Default is false


Usage
=====

* Download Visual Studio 2008 Professional (x86) - ISO: from the source "https://msdn.microsoft.com/subscriptions/json/GetDownloadRequest?brand=MSDN&locale=en-US&fileId=14233&activexDisabled=true&akamaiDL=false")
* Download Visual Studio 2008 SP1 - ISO: https://msdn.microsoft.com/subscriptions/json/GetDownloadRequest?brand=MSDN&locale=en-us&fileId=37031&activexDisabled=true&akamaiDL=false
* Place the ISOs you downloaded on a network share 
* created and ran a Chef recipe (publish soon) on a seperate to configure a Microsoft IIS that created an internal HTTP website to point the file share.
* Override the default attributes to match your network environment, ideally using a hostname instead of an IP (see attributes section, above)

The allowed us to serve the ISO, EXE, ZIP, MSI, etc... from an internal HTTP site. The HTTP is better than using Windows NTFS network file share since we don'tt have specify any user/password credentials.

Please view sample role file "sample.role.vs2008-professional-x14-26326.rb" for better understanding.


License and Author
==================

* Author:: Yeung Siu (yeung.siu@citrix.com)
* Contributors: Raymond Loiseau (ray6568@yahoo.com)

Copyright:: 2015 Citrix Systems, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
