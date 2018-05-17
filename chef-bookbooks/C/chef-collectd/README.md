# chef-collectd

This is a Chef cookbook which installs and configures collectd. It tries to be
minimalistic as possible whilst remaining flexible enough to configure anything
in collectd through attributes to ease integration with other cookbooks.

## Requirements

### Platform

* Chef >= 12.19.36
* Ubuntu >= 15.04

## Attributes

The configuration is automatically generated from `node['collectd']['conf']`.
Each configuration is defined under a _namespace_. Each namespace is written as
separate file, and all defined namespaces are included under the global 
configuration file.

The example:
```
default['collectd']['conf']['global']['FQDNLookup'] = true
default['collectd']['conf']['disk']['LoadPlugin df']['Interval'] = 3600
```
... will generate the following three files:

`/etc/collectd.conf`
```
Include "/etc/collectd/collectd.conf.d/global.conf"
Include "/etc/collectd/collectd.conf.d/disk.conf"
```

`/etc/collectd.conf.d/global.conf`
```
FQDNLookup true
```

`/etc/collectd.conf.d/disk.conf`
```
<LoadPlugin df>
  Interval 3600
</LoadPlugin>
```
