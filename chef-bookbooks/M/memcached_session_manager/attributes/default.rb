default['memcached_session_manager']['version'] = '1.8.3'
default['memcached_session_manager']['flavor'] = 'memcached'

default['memcached_session_manager']['tomcat']['base_version'] = '7'
default['memcached_session_manager']['tomcat']['lib'] = '$CATALINA_HOME/lib/'

default['memcached_session_manager']['memcached']['spymemcached'] = '2.11.1'

default['memcached_session_manager']['couchbase']['couchbase-client'] = '1.4.0'
default['memcached_session_manager']['couchbase']['jettison'] = '1.3'
default['memcached_session_manager']['couchbase']['commons-codec'] = '1.5'
default['memcached_session_manager']['couchbase']['httpcore'] = '4.3'
default['memcached_session_manager']['couchbase']['httpcore-nio'] = '4.3'
default['memcached_session_manager']['couchbase']['netty'] = '3.5.5.Final'

default['memcached_session_manager']['custom_serializer']['group_id'] = 'de.javakaffee.msm'
default['memcached_session_manager']['custom_serializer']['artifact_id'] = 'msm-kryo-serializer'
default['memcached_session_manager']['custom_serializer']['version'] = node['memcached_session_manager']['version']
