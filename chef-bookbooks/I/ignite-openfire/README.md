
# Description
Installs the [Openfire Jabber server](http://www.igniterealtime.org/) from package.

# Supported Platforms
* CentOS, Red Hat
* Windows (2012r2)

## Database
Uses the internal database packaged with Openfire

# Attributes
When changing the version also change the checksum associated with that file type e.g. for `exe` packages
```
node['openfire']['version']
node['openfire']['checksum']['4.0.3']['exe']
```

# Usage
Add this recipe to the nodes run list for default behaviour.

#TODO
- Add plugin support (e.g. for clustering)
- AWS support (tbc)
- openfire.xml configuration
- External DB support (i.e. use RDS)
