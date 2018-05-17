# StegoSOC Cookbook

## Description : 
>StegoSOC is an cloud security platform which provides continously real time monitoring for system logs, application logs, files, and kernel. Detects relevant security events and triggers security alerts.

### Supported Distributions:-
    - Ubuntu
    - CentOS
    - RHEL
    - Fedora
    - Amazon Linux

### Chef
    - Chef 12+

### Cookbooks
    - None

### Recipes
- **wazuh_repo**  : Configures repository to avail wazuh packages for various platforms
- **coon** : 
    - Installs wazuh client
    - Installs ClamAV
    - Updates ClamAV .cvd database with latest signatures

### Cookbook's default attributes
    
```
default['stegosoc']['wazuh-manager']['ip'] = '127.0.0.1' # Add Wazuh-Manager's Private-IP Address
default['stegosoc']['wazuh-manager']['port'] = '1515'

default['stegosoc']['coon']['agent_unique_name'] = "#{node['hostname']}".tr("-",'')
default['stegosoc']['coon']['syscheck_frequency'] = '3600'

```
> - Provide necessary configuration parameters with **Overriding Attributes**
> - Update ['stegosoc']['wazuh-manager']['ip'] with **Hound's server IP**
> - Update ['stegosoc']['coon']['agent_unique_name'] with **Unique Name of Agent** _(default is server's host name)_

## Coon Configuration run_list- 

```
- run_list : 'recipe[stegosoc::coon]'
```
