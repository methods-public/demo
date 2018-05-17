skype Cookbook
==============
Skype is a freemium voice over IP service and instant messaging client. 
<br>
This cookbook would install a skype client on your windows-based machine.

Platform
------------
	Windows (7, 8, 8.1);
	Windows Server (2008, 2008R2, 2012).
	

Attributes
----------
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['skype']['source']</tt></td>
    <td>String</td>
    <td>Download link</td>
    <td><tt>http://www.skype.com/go/getskype-msi/SkypeSetup.msi</tt></td>
  </tr>
  <tr>
    <td><tt>:install_directory</tt></td>
    <td>String</td>
    <td>Installation directory</td>
    <td><tt>C:\Program Files (x86)\skype </tt></td>
  </tr>
  <tr>
    <td><tt>:all_users</tt></td>
    <td>String</td>
    <td>single user / all users</td>
    <td><tt>0 (Set 1 to install for all users)</tt></td>
  </tr>
</table>

Usage
-----
This cookbook download skype from `node['skype']['source']` and install them in :install_directory.
<br>
Use a single-line comment in `%cookbook_home%/providers/default.rb::options` to run install as default.

License & Authors
-----------------
    2014, Pavel_Danelian@outlook.com
 ```text
  Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

```
