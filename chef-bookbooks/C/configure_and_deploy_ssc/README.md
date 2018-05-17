Configure and deploy HPE Fortify Software Security Center Chef Cookbook
==============
The HPE Fortify Software Security Center is a Java-based web application used to aggregate the scan results of Fortify SCA, Fortify WebInspect and other software security vulnerability scanners. This cookbook downloads, configures and deploys Software Security Center, MySQL, and Tomcat 8.

This cookbook relies on the following files being placed at "['configure_ssc']['resource_url']" on your local network.

- HPE_Security_Fortify_SSC_XX.XX_Server_WAR.zip
- mysql-connector-java-5.1.26-bin.jar
- HP_Fortify_PCI_Basic_Seed_Bundle_20XX_QX.zip
- HP_Fortify_Process_Seed_Bundle_20XX_QX.zip
- HP_Fortify_Report_Seed_Bundle_20XX_QX.zip

Where "X" represents either the SSC or Seed Bundle release number for the files mentioned above.
See the "Resource Urls" and "Package Names" sections of the attributes/default.rb file.

PLEASE NOTE:
 
- This cookbook has been tested with SSC version [16.11] 
- This cookbook  does not upgrade existing SSC instances. If an instance of SSC is detected in the Tomcat webapps directory, execution will abort.
- The version number on this cookbook and also in future releases will match the Fortify release numbers.
- If there bug fix releases for the cookbook on a corresponding Fortify release, then the 3rd number in the version number will be incremented
  - For example: 16.11.0 -> 16.11.1
- You NEED to set the attribute ['java']['oracle']['accept_oracle_download_terms'] to "true" in the attributes file in order for the oracle installation to work. The default setting is false due to licensing concerns.

Requirements
------------
### Platforms
- RHEL 7
- CentOS 7

### Chef
- Chef >= 12.12. May work on earlier versions.

Additional Information
----------------------
### How this cookbook works:
This cookbook works by adding the OS specific recipe to the node's run-list.  Major actions to install Fortify SSC are broken out in to their own recipes to make things a little more modular should the default recipes not be in line with your existing infrastructures current configuration or requirements.

For example the following is the hierarchy and order by which recipes will be executed for the recipe "configure_and_deploy_ssc::rhel":

* rhel
  * rhel_install_java
  * rhel_install_tomcat8
  * rhel_install_mysql
  * rhel_workspace_setup
      * rhel_download_ssc_files
  * rhel_create_db
  * rhel_configure_war
  * rhel_seed_db
  * rhel_deploy_ssc_war
  * rhel_node_security_settings

### To-do items:
- Make it so that you can deploy/download the “fortify.license” file rather than distributing it as a template
- There seems to be a bug with trying to start tomcat 8 as a systemd service on CentOS/RHEL. The server will start up with no errors, but will fail to render any of the pages unless you start it manually as root.  Need to investigate more. 
- Re-Integrate the Windows attributes and recipe to this cookbook.  Logic will need to be present so that the windows attributes will not activate when not being run on a Windows system.
- Update comments to inform the operator how to change attributes to handle different servlet containers besides Tomcat
  - This may also entail having to have recipes for installing those other servlet containers (eg: jboss)
- Update comments to imform the operator how to change attributes to handle different databases besides MySQL
  - This may also enatil having to have recipes for installing those other databases (eg: MS-SQL, Oracle, Derby, etc...)
- Create a recipe or new cookbook altogether to installing SCA
- Create recipes for hardening the database and app server installations
- Create a recipe to enable smart-card/CAC based authentication
- Create OS detecting attribute files

Quick Install
-------------
This assumes you're going to be uploading this cookbook to a chef server. There are some required dependencies that you'll need to download. Follow the instructions below to get this cookbook along with the other required cookbooks uploaded to your chef server quickly:

- Ensure you're running ChefDK version >= 0.19.6
- Copy this cookbook to your chef repo
- Open a terminal/console and change directory to this cookbook
- Copy the contents of your "fortify.license" file to "templates/default/fortify.license.erb"
- Set the attribute ['java']['oracle']['accept_oracle_download_terms'] to "true" in the attributes file
- Ensure the SSC zip, Seed Bundles, and MySQL JDBC jar are placed at "['configure_ssc']['resource_url']" on your local network
- Type in the following commands:

[dev@chef-ws1 ~]# berks install

[dev@chef-ws1 ~]# berks upload

- At this point the cookbook and it's needed dependencies should be on the chef server. Just add "configure_and_deploy_ssc::rhel" to that targeted node's run-list.
