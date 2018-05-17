#
# Cookbook Name:: kkafka
# Recipe:: _defaults
#

unless broker_attribute?(:broker, :id)
  node.default.kkafka.broker.broker_id = node.ipaddress.gsub('.', '').to_i % 2**31
end

unless broker_attribute?(:port)
  node.default.kkafka.broker.port = 6667
end

unless node.kkafka.gc_log_opts
  node.default.kkafka.gc_log_opts = %W[
    -Xloggc:#{node.kkafka.log_dir}/kafka-gc.log
    -XX:+PrintGCDateStamps
    -XX:+PrintGCTimeStamps
  ].join(' ')
end

unless node.kkafka.config_dir
  node.default.kkafka.config_dir = ::File.join(node.kkafka.install_dir, 'config')
end

unless node.kkafka.version_install_dir
  node.default.kkafka.version_install_dir = %(#{node.kkafka.install_dir}-#{node.kkafka.version})
end

unless broker_attribute?(:database, :type)
  node.default.kkafka.broker.database.type = "mysql"
end

unless broker_attribute?(:database, :url)
  mysql_host = private_recipe_ip("ndb","mysqld")
  node.default.kkafka.broker.database.url = "#{mysql_host}:#{node.ndb.mysql_port}/hopsworks"
end
unless broker_attribute?(:database, :username)
  node.default.kkafka.broker.database.username = node.mysql.user
end
unless broker_attribute?(:database, :password)
  node.default.kkafka.broker.database.password = node.mysql.password
end
