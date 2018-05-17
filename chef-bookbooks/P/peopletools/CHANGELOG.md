peopletools Cookbook CHANGELOG
==============================

2.4.0 (2017-12-14)
------------------
- Added 8.56 functionality and rubocop fixes.

2.3.7 (2016-12-05)
------------------
- Added psserver variable to the webserver_domain template.

2.3.6 (2016-10-28)
------------------
- Tidied up InSpec tests.

2.3.5 (2016-10-14)
------------------
- Tidied up InSpec tests.

2.3.4 (2016-10-14)
------------------
- Renamed webserver_domain response_file properties for clarity.

2.3.3 (2016-10-13)
------------------
- Updated order of webserver_domain properties.

2.3.2 (2016-10-12)
------------------
- Updated examples and tests to use different passwords.

2.3.1 (2016-10-12)
------------------
- Updated webserver_domain resource properties.

2.3.0 (2016-10-11)
------------------
- Added webserver_domain resource.

2.2.0 (2016-10-07)
------------------
- Added prcs_domain resource.

2.1.4 (2016-10-06)
------------------
- Added sensitive property to execute resources to protect passwords.

2.1.3 (2016-10-06)
------------------
- Corrected bashrc variables to match properties.

2.1.2 (2016-10-06)
------------------
- Updated properties for bashrc resource.

2.1.1 (2016-10-04)
------------------
- Added port_settings property to appserver_domain resource and updated readme.

2.1.0 (2016-10-03)
------------------
- Added appserver_domain resource and tests.

2.0.0 (2016-09-29)
------------------
- Removed attributes and recipes and updated some resource properties.

1.2.5 (2016-05-12)
------------------
- Changed additional_commands property to custom_commands in bashrc resource and set default.

1.2.4 (2016-05-11)
------------------
- Added additional_commands property to bashrc resource.

1.2.3 (2016-05-10)
------------------
- Added ps_cust_home_dir variable to bashrc template.

1.2.2 (2016-05-10)
------------------
- Changed bashrc ps_cfg_home_dir and ps_cust_home_dir property defaults.

1.2.1 (2016-05-06)
------------------
- Changed bashrc and tnsnames resources to use path as name property.

1.2.0 (2016-05-06)
------------------
- Added bashrc resource.

1.1.0 (2016-05-05)
------------------
- Added tnsnames resource.

1.0.1 (2016-04-08)
------------------
- Modified guard for tuxedo to avoid install order issues with weblogic.

1.0.0 (2016-04-08)
------------------
- Renamed ps_apphome resource to ps_app_home to match Oracle references.

0.3.4 (2016-04-07)
------------------
- Removed setting of password for users; tidied up system recipe/attributes.

0.3.3 (2016-04-06)
------------------
- Renamed default oracle user from oracle2 to oracle.

0.3.2 (2016-04-05)
------------------
- Moved sysctl attributes from attributes file to system recipe to prevent issues with wrapper cookbooks.

0.3.1 (2016-03-03)
------------------
- Updated deploy user/group for ps_apphome to match Oracle default.

0.3.0 (2016-03-03)
------------------
- Added attribute to allow ps_apphome archive_repo to be different from the peopletools archive_repo and updated Readme.

0.2.0 (2016-03-03)
------------------
- Added limits attributes and configuration for psft_runtime and psft_app_install groups.

0.1.3 (2016-03-01)
------------------
- Changed deployment resources property from archive_file to archive_url.

0.1.2 (2016-03-01)
------------------
- Added cookbook property to template resources to prevent wrapper cookbook issues.

0.1.1 (2016-02-29)
------------------
- Fixed RuboCop offenses; updated Readme.

0.1.0 (2016-02-29)
------------------
- Initial release of peopletools.
