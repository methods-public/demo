resource_name :galera_init

property :cluster_init_node, String, name_property: true
property :socket, String, default: '/var/lib/mysql/mysql.sock'
property :root_pw, String
property :sst_user, String, default: 'sstuser'
property :sst_pw, String

default_action :create

action :create do
  ::File.socket?(socket) ? (node.default['galera']['cluster'] = true) : node.default['galera'].delete('cluster')
  cluster = search(:node, 'role:galera').first['galera']['cluster']

  execute 'galera new cluster' do
    command 'galera_new_cluster'
    only_if 'test -S #{socket}'
  end if (node['hostname'] == cluster_init_node) && !cluster

  execute 'secure installation and add cluster user' do
    command <<-EOH
      mysql -u root -p'' -e \
      "UPDATE mysql.user SET Password=PASSWORD('#{root_pw}') WHERE User='root'; \
      DELETE FROM mysql.user WHERE User=''; \
      DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); \
      DROP DATABASE IF EXISTS test; \
      DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'; \
      CREATE USER '#{sst_user}'@'localhost' IDENTIFIED BY '#{sst_pw}'; \
      GRANT PROCESS, RELOAD, LOCK TABLES, REPLICATION CLIENT ON *.* TO '#{sst_user}'@'localhost'; \
      FLUSH PRIVILEGES;"
    EOH
    only_if %q(mysql --no-defaults -u root -e "SHOW GLOBAL STATUS LIKE 'uptime';")
  end if node['hostname'] == cluster_init_node
end
