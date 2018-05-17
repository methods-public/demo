# Client Bootstap by Chef-Server


This Cookbook will helps you to Bootstrap new Nodes by recipe.

## Platforms

- Windows
- Redhat
- Centos
- Fedora

## Requirements

First of all you need an already bootstraped Linux Node with installed ChefDK.

### Data Bags

You need to add the following DataBags:

- bootstrap
- sources

#### DataBag Item

In the DataBag sources you have to create a DataBag Item named bootstrapping with a download link for each platform you want to bootstrap.

##### DataBag Syntax example

``` 
{
  "windows": "http://link2Chef-Client.msi",
  "redhat": "http://link2Chef-client.rpm"
}
```

For each Node you want to bootstrap you have to create a DataBag Item

##### DataBag Syntax Windows

``` 
{
 "platform": "windows",
  "hostname": "HOSTNAME",
  "fqdn": "FQDN",
  "domain": "DomainName",
  "user": "UserOnTheRemoteSystem",
  "passwd": "yourpasswd",
  "environment": "_default",
}
```

##### DataBag Syntax Linux

``` 
{
 "platform": "redhat", # or centos or fedora
  "hostname": "HOSTNAME",
  "fqdn": "FQDN",
  "domain": "DomainName",
  "user": "UserOnTheRemoteSystem",
  "passwd": "yourpasswd",
  "environment": "_default",
}
```

## Execute

Edit the runlist of your Linux Workstation Node ;) and add the chef_bootstrap cookbook.

The recipe will add a line (bootstraped = true) to the DataBag content after finishing.

## License & Authors

### Author: 

Frederik

### License

``` 
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


