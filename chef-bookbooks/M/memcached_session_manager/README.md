# Memcached Session Manager Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/memcached_session_manager.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-memcached_session_manager.svg?style=flat-square)][travis]
[![GitHub Issues](http://img.shields.io/github/issues/dhoer/chef-memcached_session_manager.svg?style=flat-square)][github]

[cookbook]: https://supermarket.chef.io/cookbooks/memcached_session_manager
[travis]: https://travis-ci.org/dhoer/chef-memcached_session_manager
[github]: https://github.com/dhoer/chef-memcached_session_manager/issues

Installs/Configures Tomcat high-availability clusters with memcached using Martin Grotzke's 
https://code.google.com/p/memcached-session-manager.

## Requirements

- This cookbook expects `$CATALINA_HOME` to be defined in the environment. If `$CATALINA_HOME` is not defined, then 
please override `node['memcached_session_manager']['tomcat']['lib']` attribute.
- Java & Tomcat must be installed outside of this cookbook.
- Chef 11.14 or higher.

### Platforms

- CentOS
- RedHat
- Ubuntu

## Usage

The `default` recipe adds required memcached_session_manager jars to Tomcat.  Use the attributes below to configure
memcached_session_manager.  Note `memcached_session_manager_context` resource will automatically include the default 
recipe. 

### Attributes
- `node['memcached_session_manager']['version']` - The version of memcached_session_manager to install. 
- `node['memcached_session_manager']['flavor']` - Flavors `memcached` and `couchbase` are supported. 
Defaults to `memcached`.
- `node['memcached_session_manager']['tomcat']['base_version']` - Defaults to `7`.
- `node['memcached_session_manager']['tomcat']['lib']` -  Defaults to `$CATALINA_HOME/lib/`. 
Be sure to override this if $CATALINA_HOME is not defined in your environment.
- `node['memcached_session_manager']['memcached']['spymemcached']` -  
The version of `spymemcached` to install for `memcached`.
- `node['memcached_session_manager']['couchbase']['couchbase-client']` -
The version of `couchbase-client` to install for `couchbase`.
- `node['memcached_session_manager']['couchbase']['jettison']` -
The version of `jettison` to install for `couchbase`.
- `node['memcached_session_manager']['couchbase']['commons-codec']` -
The version of `commons-codec` to install for `couchbase`.
- `node['memcached_session_manager']['couchbase']['httpcore']` -
The version of `httpcore` to install for `couchbase`.
- `node['memcached_session_manager']['couchbase']['httpcore-nio']` -
The version of `httpcore-nio` to install for `couchbase`.
- `node['memcached_session_manager']['couchbase']['netty'] ` -
The version of `netty` to install for `couchbase`.


## LWRP

### memcached_session_manager_context
Updates the <Context> element in `context.xml` so that it contains the Manager configuration for the 
memcached-session-manager, like in the examples below. 

The following examples show configurations for sticky sessions and non-sticky sessions with memcached servers and 
for non-sticky sessions with membase. The examples with memcached servers assume that there are two memcacheds 
running, one on host1 and another one on host2. All sample configurations assume that you want to use kryo based 
serialization.

##### Example for sticky sessions + kryo
The following example shows the configuration of the first tomcat, assuming that it runs on host1, together with
memcached "n1". The attribute failoverNodes="n1" tells msm to store sessions preferably in memcached "n2" and only 
store sessions in "n1" (running on the same host/machine) if no other memcached node (here only n2) is available 
(even if host1 goes down completely, the session is still available in memcached "n2" and could be served by the 
tomcat on host2). For the second tomcat (on host2) you just need to change the failover node to "n2", so that it 
prefers the memcached "n1". Everything else should be left unchanged.

```ruby
memcached_session_manager_context '/path/to/context.xml' do
  memcachedNodes 'n1:host1.yourdomain.com:11211,n2:host2.yourdomain.com:11211'
  failoverNodes 'n1'
  requestUriIgnorePattern '.*\.(ico|png|gif|jpg|css|js)$'
end
```


##### Example for non-sticky sessions + kryo
The following example shows a configuration for non-sticky sessions. In this case there's no need for failoverNodes, 
as sessions are served by all tomcats round-robin and they're not bound to a single tomcat. For non-sticky sessions 
the configuration (for both/all tomcats) would look like this:

```ruby
memcached_session_manager_context '/path/to/context.xml' do
  memcachedNodes 'n1:host1.yourdomain.com:11211,n2:host2.yourdomain.com:11211'
  sticky false
  sessionBackupAsync false
  lockingMode 'uriPattern:/path1|/path2'
  requestUriIgnorePattern '.*\.(ico|png|gif|jpg|css|js)$'
end
```


##### Example for non-sticky sessions with couchbase + kryo
To connect to a membase bucket `bucket1` the configuration would look like this:

```ruby
memcached_session_manager_context '/path/to/context.xml' do
  memcachedNodes 'http://host1.yourdomain.com:8091/pools'
  username 'bucket1'
  password 'topsecret'
  memcachedProtocol 'binary'
  sticky false
  sessionBackupAsync false
  requestUriIgnorePattern '.*\.(ico|png|gif|jpg|css|js)$'
end
```


##### Example for multiple contexts sharing the same session id
If you are running multiple webapps/contexts sharing the same session id (e.g. by having set sessionCookiePath="/") 
you must tell memcached session manager to add a prefix to the session id when storing a session in memcached. 
For this you can use the storageKeyPrefix attribute as shown by this example (see also the more detailed attribute 
description below):

```ruby
memcached_session_manager_context '/path/to/context.xml' do
  memcachedNodes 'n1:host1.yourdomain.com:11211,n2:host2.yourdomain.com:11211'
  failoverNodes 'n1'
  storageKeyPrefix 'context'
  requestUriIgnorePattern '.*\.(ico|png|gif|jpg|css|js)$'
end
```

#### Actions

- `install` - Adds or updates the <Context> element in `context.xml` so that it contains the Manager configuration for 
the memcached-session-manager.
- `remove` - Removes the <Context> element in `context.xml` so that it contains the Manager configuration for 
the memcached-session-manager.

#### Attributes
Documentation below has been trimmed down from the original.  Please read the complete documentation 
[here](https://code.google.com/p/memcached-session-manager/wiki/SetupAndConfiguration#Overview_over_memcached-session-manager_configuration_attributes).

- `path` (required) - Defaults to name of the resource block. Specifies direct path to context.xml file.
- `className` - Defaults to `de.javakaffee.web.msm.MemcachedBackupSessionManager`. 
- `memcachedNodes` (required) - This attribute must contain all memcached nodes you have running, or the membase 
bucket uri(s). It should be the same for all tomcats.
- `failoverNodes` (optional, must not be used for non-sticky sessions) - Defaults to `nil`. Specifies ids of the 
memcached nodes that must only be used for session backup when none of the other memcached nodes are available. 
Several memcached node ids are separated by space or comma.
- `username` - Defaults to `nil`. Specifies the username used for a membase bucket or SASL. 
- `password` - Defaults to `nil`. Specifies the password used for membase bucket or SASL authentication 
(can be left empty / omitted if the "default" membase bucket without a password shall be used).
- `memcachedProtocol` - Defaults to `text` - Specifies the memcached protocol to use, one of `text` or 
`binary`.
- `sticky` - Defaults to `true`. Specifies if sticky or non-sticky sessions are used.
- `lockingMode` (optional, for non-sticky sessions only) - Defaults to `none`. Specifies the locking strategy 
for non-sticky sessions. Session locking is useful to prevent concurrent modifications and lost updates of the session 
in the case of parallel requests. Session locking is done using memcached. Possible values for lockingMode are: 
`none`, `all`, `auto`, and `uriPattern:<regexp>`.
- `requestUriIgnorePattern` - Defaults to `nil`. Specifies a regular expression for request URIs, that shall not 
trigger a session backup. 
- `sessionBackupAsync` - Defaults to `true`. Specifies if the session shall be stored asynchronously in memcached. 
If this is true, the backupThreadCount setting is evaluated. If this is false, the timeout set via sessionBackupTimeout 
is evaluated.
- `backupThreadCount` - Defaults to `nil` (number-of-cpu-cores). The number of threads that are used for asynchronous 
session backup (if sessionBackupAsync="true"). For the default value the number of available processors (cores) is used.
- `sessionBackupTimeout` - Defaults to `100` milliseconds. The timeout in milliseconds after that a session backup is 
considered as being failed. This property is only evaluated if sessions are stored synchronously 
(set via sessionBackupAsync). 
- `operationTimeout` - Defaults to `1000`. The memcached operation timeout used at various places, e.g. used for the 
spymemcached ConnectionFactory.
- `storageKeyPrefix` - Defaults to `webappVersion` Allows to configure a prefix that's added to the session id when a 
session is stored in memcached. 
- `sessionAttributeFilter` - Defaults to `nil`. A regular expression to control which session attributes are serialized 
to memcached. 
- `transcoderFactoryClass` - Defaults to `de.javakaffee.web.msm.JavaSerializationTranscoderFactory`.
- `copyCollectionsForSerialization` - Defaults to `false`. A boolean value that specifies, if iterating over collection 
elements shall be done on a copy of the collection or on the collection itself. 
-  `customConverter` - Defaults to `nil`. Custom converter allow you to provide custom serialization of application 
specific types. Multiple custom converter class names are specified separated by comma (with optional space following 
the comma). Converter classes must be available in the classpath of the web application (place jars in WEB-INF/lib).
- `enableStatistics` - Defaults to `true`. A boolean value that specifies, if statistics shall be gathered. 
- `enabled` - Defaults to `true`. Specifies if session storage in memcached is enabled or not, can also be changed at 
runtime via JMX. Only allowed in sticky mode.


## ChefSpec Matchers

This cookbook includes custom [ChefSpec](https://github.com/sethvargo/chefspec) matchers you can use to test 
your own cookbooks.

Example Matcher Usage

```ruby
expect(chef_run).to install_memcached_session_manager_context('/path/to/context.xml').with(
  memcachedNodes: 'n1:host1.yourdomain.com:11211,n2:host2.yourdomain.com:11211',
  failoverNodes: 'n1',
  storageKeyPrefix: 'context',
  requestUriIgnorePattern: '.*\.(ico|png|gif|jpg|css|js)$'
)
```

Cookbook Matchers

- install_memcached_session_manager_context(path)
- remove_memcached_session_manager_context(path)


## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef).
- Report bugs and discuss potential features in 
[Github issues](https://github.com/dhoer/chef-memcached_session_manager/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-memcached_session_manager/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-memcached_session_manager/blob/master/LICENSE.md) 
file for details.
