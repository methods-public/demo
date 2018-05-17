# Nscp Chef Cookbook

### Description
NSClient++ is used as a monitoring agent on Windows. This cookbook installs it in NRPE (legacy) mode. Also it provides LWRP to create additional script checks.

### Requirements

#### Platforms
Tested only on Windows Server 2012 R2.

### Attributes
Root for all attributes is `node['nscp']`.

|Attribute|Description|Type|Default|
|---------|-----------|----|-------|
|`['config']`|Configuration values for `nsclient.ini` are stored here.|Hash|Check `attributes/default.rb`|
|`['template_cookbook']`|Name of the cookbook where configuration templates are stored.|String|'nscp'|
|`['template_name']`|Name of template file for `nsclient.ini` config.|String|'nsclient.ini.erb'|
|`['template_scripts_name']`|Name of template file for `nsclient_scripts.ini` config.|String|'nsclient_scripts.ini.erb'|
|`['service_name']`|Name of the NSClient++ service.|String|'nscp'|


### Recipes

* `default.rb` - Install and configure NSClient++.


### Resources

#### nscp_check

Used to create additional script checks. Every check is saved in node attributes.

|Property|Description|Type|Default|
|--------|-----------|----|-------|
|`command_name`|Unique command name. This command then called from check_nrpe.|String||
|`command`|Script name to execute. Currently only scripts in `<nsclient_folder>/scripts` are supported. Put custom scripts there using `template` or `cookbook_file` resources. Arguments are supported.|String||
|`arguments`|Arguments array to be used with check. ATTENTION: These values are not for NSClient++ configuration, but for Nagios, Icinga, etc. to run with check_nrpe.|Array|[]|


### Kitchen
```bash
# check style
chef exec rake style
# converge and run tests
chef exec rake integration:vagrant
```

### Examples
For examples see `test/fixtures/cookbooks/test` cookbook.

### Authors
* Author:: Azat Khadiev (anuriq@gmail.com)
