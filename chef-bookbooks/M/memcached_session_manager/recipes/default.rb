include_recipe 'maven::default'

case node['platform_family']
when 'rhel', 'debian'
  maven 'memcached-session-manager' do
    group_id 'de.javakaffee.msm'
    version node['memcached_session_manager']['version']
    dest node['memcached_session_manager']['tomcat']['lib']
  end

  maven "memcached-session-manager-tc#{node['memcached_session_manager']['tomcat']['base_version']}" do
    group_id 'de.javakaffee.msm'
    version node['memcached_session_manager']['version']
    dest node['memcached_session_manager']['tomcat']['lib']
  end

  flavor = node['memcached_session_manager']['flavor']
  if flavor == 'memcached'
    maven 'spymemcached' do
      group_id 'net.spy'
      version node['memcached_session_manager']['memcached']['spymemcached']
      dest node['memcached_session_manager']['tomcat']['lib']
    end
  elsif flavor == 'couchbase'
    maven 'couchbase-client' do
      group_id 'com.couchbase.client'
      version node['memcached_session_manager']['couchbase']['couchbase-client']
      dest node['memcached_session_manager']['tomcat']['lib']
    end

    maven 'jettison' do
      group_id 'org.codehaus.jettison'
      version node['memcached_session_manager']['couchbase']['jettison']
      dest node['memcached_session_manager']['tomcat']['lib']
    end

    maven 'commons-codec' do
      group_id 'commons-codec'
      version node['memcached_session_manager']['couchbase']['commons-codec']
      dest node['memcached_session_manager']['tomcat']['lib']
    end

    maven 'httpcore' do
      group_id 'org.apache.httpcomponents'
      version node['memcached_session_manager']['couchbase']['httpcore']
      dest node['memcached_session_manager']['tomcat']['lib']
    end

    maven 'httpcore-nio' do
      group_id 'org.apache.httpcomponents'
      version node['memcached_session_manager']['couchbase']['httpcore-nio']
      dest node['memcached_session_manager']['tomcat']['lib']
    end

    maven 'netty' do
      group_id 'io.netty'
      version node['memcached_session_manager']['couchbase']['netty']
      dest node['memcached_session_manager']['tomcat']['lib']
    end
  else
    fail("node['memcached_session_manager']['flavor'] = '#{flavor}' is not supported!")
  end
else
  log('memcached_session_manager cannot be installed on this platform using this cookbook')
end
