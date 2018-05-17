#Description

This cookbook will manage to configure war file in tomcate home directory after the installation of tomcat .

Note: This cookbook is in work in progress. This is the initial release with version 0.1.0. There have been some breaking changes in recent releases.

#tomcat_install Cookbook

1. It changes the catalina.properties file in the shared.loader section
2. It will create a file of backup in the home directory of tomcat {/usr/local/tomcat9/shared/classes/backup.properties}.
3. It changes the context.xml file in the shared.loader section.

e.g. This cookbook makes your favorite breakfast sandwich.

#Requirements

Dependency cookbook is "tomcat_config"
Best practices to create private central repository - e.g. - apache/nginx/tomcat java version "1.8.0_121"

#Platforms

CentOS
RedHat
#Chef

Chef 12.0 or later
#Cookbooks

toaster - tomcat_install needs toaster to brown your bagel.
#Usage

Data Bag need to crate with data bag name "data_bag_name" and data bag item name "context-user" as it will setup the user account in context.xml file.

#LICENSE and AUTHOR:

Author:: Suvadip Mandal (<suvadipmandal@gmail.com>). Version 2.0 (the "License"); you may not use this file except in compliance with the License.

You may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.


e.g. Just include tomcat_install in your node's run_list:

{
  "name":"my_node",
  "run_list": [
    "recipe[tomcat_install]"
  ]
}
#Contributing
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g. 1. Fork the repository on Github 2. Create a named feature branch (like add_component_x) 3. Write your change 4. Write tests for your change (if applicable) 5. Run the tests, ensuring they all pass 6. Submit a Pull Request using Github
