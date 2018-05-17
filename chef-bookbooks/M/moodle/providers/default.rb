use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end


action :create do
  converge_by("Create #{ @new_resource }") do
    create_moodle_instance
  end
end
def create_moodle_instance
  if new_resource.dbhost == "localhost"
    run_context.include_recipe "percona::server"
    run_context.include_recipe "percona::toolkit"
    run_context.include_recipe "percona::backup"
  end

  if new_resource.dbtype == 'mysqli'
    package 'php-mysql'
  end

  run_context.include_recipe "nginx"
  run_context.include_recipe "php-fpm"
  run_context.include_recipe "database::mysql"

  template ::File.join(node['nginx']['dir'], "sites-available",
  new_resource.server_name + ".conf") do
    source "moodle-nginx.conf.erb"
    owner node['nginx']['user']
    group node['nginx']['group']
    mode 0644
    variables(
      :server_name => new_resource.server_name,
      :web_root => new_resource.web_root,
      :dbsocket => new_resource.dbsocket
    )
  end

  directory ::File.join(node['nginx']['dir'], "webapps/php-fpm") do
    action :create
    recursive true
  end

  template ::File.join(node['nginx']['dir'], "webapps/php-fpm",
  new_resource.server_name + ".conf") do
    source "php-fpm-nginx.conf.erb" 
    owner node['nginx']['user']
    group node['nginx']['group']
    mode 0644
    variables :fastcgi_pass => new_resource.fastcgi_pass
  end

  template ::File.join(new_resource.config_dir, "config.php") do
    owner node['php-fpm']['user']
    group node['php-fpm']['group']
    mode 0700
    variables(
      :admin => new_resource.admin,
      :dbhost => new_resource.dbhost,
      :dbname => new_resource.dbname,
      :dbpass => new_resource.dbpass,
      :dbpersist => new_resource.dbpersist,
      :dbport => new_resource.dbport,
      :dbsocket => new_resource.dbsocket,
      :dbtype => new_resource.dbtype,
      :dbuser => new_resource.dbuser,
      :passwordsalt1 => new_resource.passwordsalt1,
      :passwordsaltmain => new_resource.passwordsaltmain,
      :dbprefix => new_resource.dbprefix,
      :server_name => new_resource.server_name,
      :web_root => new_resource.web_root
    )
  end

  cookbook_file ::File.join(node['nginx']['dir'], "webapps",
  "moodle-nginx.conf") do
    owner node['nginx']['user']
    group node['nginx']['group']
    mode 0644
  end

  cookbook_file "/etc/nginx/fastcgi_params" do
    owner "nginx"
    group "nginx"
    mode 0644
  end

  # We implicitly redefine new_resource in the php_fpm_pool resource
  # so explicitly set web_root
  web_root = new_resource.web_root
  php_fpm_pool new_resource.fastcgi_pass do
    php_options "php_value[include_path]" => web_root
  end

  if new_resource.create_db_and_user
    mysql_database_user new_resource.dbuser do
      connection({ :host => new_resource.dbhost, :user => 'root',
      :password => new_resource.dbrootpass })
      password new_resource.dbpass
      privileges [:all]
      action [:grant]
    end

    mysql_database new_resource.dbname do
      connection({ :host => new_resource.dbhost, :user => new_resource.dbuser,
      :password => new_resource.dbrootpass })
      action :create
    end
  end

  nginx_site new_resource.server_name + ".conf"
end
