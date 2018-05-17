#
# Cookbook Name:: screwdriver
# Recipe:: docker-compose
#
# Copyright 2017, whitestar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

doc_url = 'https://hub.docker.com/r/screwdrivercd/screwdriver/'

::Chef::Recipe.send(:include, SSLCert::Helper)

#include_recipe 'platform_utils::kernel_user_namespace'
include_recipe 'docker-grid::compose'

default_executor = {
  'plugin' => 'docker',
  'docker' => {
    'options' => {
      'docker' => {
        'socketPath' => '/var/run/docker.sock',
      },
      'launchVersion' => 'stable',
    },
  },
}

app_dir = node['screwdriver']['docker-compose']['app_dir']
bin_dir = node['screwdriver']['docker-compose']['bin_dir']
config_dir = node['screwdriver']['docker-compose']['config_dir']
data_dir = node['screwdriver']['docker-compose']['data_dir']
etc_dir = node['screwdriver']['docker-compose']['etc_dir']

[
  app_dir,
  bin_dir,
  config_dir,
  data_dir,
  "#{etc_dir}/nginx",
].each {|dir|
  resources(directory: dir) rescue directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
}

api_config_file = "#{config_dir}/api-local.yaml"
env_file = "#{app_dir}/.env"
config_file = "#{app_dir}/docker-compose.yml"

api_config_local = nil
if File.exist?(api_config_file)
  require 'yaml'
  api_config_local = YAML.load_file(api_config_file)
end

env_local = nil
if File.exist?(env_file)
  env_local = {}
  File.open(env_file) do |file|
    file.each_line do |line|
      env_local[$1] = $2 if line =~ /^([^=]*)=(.*)$/
    end
  end
end

=begin
config_srvs_local = nil
if File.exist?(config_file)
  require 'yaml'
  config_srvs_local = YAML.load_file(config_file)['services']
end
=end

# We use plain Hash objects instead of Chef attribute objects for containg secrets (JWT key pair).
override_api_config = node['screwdriver']['api']['config'].to_hash
override_store_config = node['screwdriver']['store']['config'].to_hash
#override_api_config = node.override['screwdriver']['api']['config']      # NG
#override_store_config = node.override['screwdriver']['store']['config']  # NG

config_srvs = node['screwdriver']['docker-compose']['config']['services']
override_config_srvs = node.override['screwdriver']['docker-compose']['config']['services']
force_override_config_srvs = node.force_override['screwdriver']['docker-compose']['config']['services']

# api
api_envs_org = config_srvs['api']['environment']
api_envs = {}
api_vols = config_srvs['api']['volumes'].to_a

api_port = '9001'  # default
api_in_port = api_envs_org['PORT']
ports = config_srvs['api']['ports']
if ports.empty?
  override_config_srvs['api']['ports'] = ["#{api_port}:#{api_in_port}"]
else
  ports.each {|port|
    elms = port.split(':')
    api_port = (elms.size == 2 ? elms[0] : elms[1]) if elms.last == api_in_port
  }
end

override_api_config['executor'] = default_executor if override_api_config['executor'].empty?

[
  'jwt_private_key_vault_item',
  'jwt_public_key_vault_item',
  'cookie_password_vault_item',
  'password_vault_item',
].each {|vault_item|
  # for backward compatibility.
  if node['screwdriver'][vault_item].empty? && !node['screwdriver']['docker-compose'][vault_item].empty?
    node.force_override['screwdriver'][vault_item] = node['screwdriver']['docker-compose'][vault_item].to_hash
  end
}

jwt_private_key_reset = node['screwdriver']['docker-compose']['jwt_private_key_reset']
jwt_private_key = nil
jwt_public_key  = nil
jwt_private_key_vault_item = node['screwdriver']['jwt_private_key_vault_item']
jwt_public_key_vault_item  = node['screwdriver']['jwt_public_key_vault_item']

if !jwt_private_key_vault_item.empty?
  # 1. from Chef Vault (recommended).
  jwt_private_key = get_vault_item_value(jwt_private_key_vault_item)
  jwt_public_key  = get_vault_item_value(jwt_public_key_vault_item)
  log 'JWT key pair has been loaded from Chef Vault.'
else
  # 2. from Chef attribute (NOT recommended).
  jwt_private_key = api_envs_org['SECRET_JWT_PRIVATE_KEY']
  jwt_public_key  = api_envs_org['SECRET_JWT_PUBLIC_KEY']
  if jwt_private_key.nil? || jwt_private_key.empty?
    if !api_config_local.nil? && !api_config_local['auth']['jwtPrivateKey'].nil? && !jwt_private_key_reset
      # 3. preserve it from the local config/api-local.yaml file.
      jwt_private_key = api_config_local['auth']['jwtPrivateKey']
      jwt_public_key  = api_config_local['auth']['jwtPublicKey']
      log 'JWT key pair is preserved from the local config/api-local.yaml file.'
    # if !env_local.nil? && !env_local['SECRET_JWT_PRIVATE_KEY'].nil? && !jwt_private_key_reset
    #   # 3. preserve it from the local .env file.
    #   # Note: Docker env file format does not support backslash escaped string yet.
    #   eval "jwt_private_key = %Q(#{env_local['SECRET_JWT_PRIVATE_KEY']})"
    #   eval "jwt_public_key  = %Q(#{env_local['SECRET_JWT_PUBLIC_KEY']})"
    #   log 'JWT key pair is preserved from the local .env file.'
    else
      # 4. auto generate.
      require 'openssl'
      rsa = OpenSSL::PKey::RSA.generate(2048)
      jwt_private_key = rsa.export
      jwt_public_key  = rsa.public_key.export
      log 'JWT key pair has been generated.'
    end
  end
end

override_api_config['auth']['jwtPrivateKey'] = jwt_private_key
override_api_config['auth']['jwtPublicKey'] = jwt_public_key
# Note: prevent Chef from logging JWT key attribute values. (=> template variables)
# However Docker env file format does not support multi-line value and backslash escaped string yet.
#api_envs['SECRET_JWT_PRIVATE_KEY'] = '${SECRET_JWT_PRIVATE_KEY}'  # Useless
#api_envs['SECRET_JWT_PUBLIC_KEY']  = '${SECRET_JWT_PUBLIC_KEY}'   # Useless
#api_envs['SECRET_JWT_PRIVATE_KEY'] = jwt_private_key  # NG
#api_envs['SECRET_JWT_PUBLIC_KEY']  = jwt_public_key   # NG

cookie_password = nil
cookie_password_vault_item = node['screwdriver']['cookie_password_vault_item']
unless cookie_password_vault_item.empty?
  cookie_password = get_vault_item_value(cookie_password_vault_item)
  api_envs['SECRET_COOKIE_PASSWORD'] = '${SECRET_COOKIE_PASSWORD}'
end

password = nil
password_vault_item = node['screwdriver']['password_vault_item']
unless password_vault_item.empty?
  password = get_vault_item_value(password_vault_item)
  api_envs['SECRET_PASSWORD'] = '${SECRET_PASSWORD}'
end

node['screwdriver']['api']['scms_vault_items'].each {|scm, props|
  props.each {|prop, vault_item|
    unless vault_item.empty?
      secret = get_vault_item_value(vault_item)
      override_api_config['scms'][scm]['config'][prop] = secret
    end
  }
}
=begin
# **DEPRECATED!!**
oauth_client_id = nil
oauth_client_id_vault_item = node['screwdriver']['docker-compose']['oauth_client_id_vault_item']
unless oauth_client_id_vault_item.empty?
  oauth_client_id = get_vault_item_value(oauth_client_id_vault_item)
  api_envs['SECRET_OAUTH_CLIENT_ID'] = '${SECRET_OAUTH_CLIENT_ID}'
end

oauth_client_secret = nil
oauth_client_secret_vault_item = node['screwdriver']['docker-compose']['oauth_client_secret_vault_item']
unless oauth_client_secret_vault_item.empty?
  oauth_client_secret = get_vault_item_value(oauth_client_secret_vault_item)
  api_envs['SECRET_OAUTH_CLIENT_SECRET'] = '${SECRET_OAUTH_CLIENT_SECRET}'
end

webhook_github_secret = nil
webhook_github_secret_vault_item = node['screwdriver']['docker-compose']['webhook_github_secret_vault_item']
unless webhook_github_secret_vault_item.empty?
  webhook_github_secret = get_vault_item_value(webhook_github_secret_vault_item)
  api_envs['WEBHOOK_GITHUB_SECRET'] = '${WEBHOOK_GITHUB_SECRET}'
end
=end

db_username = nil
db_username_vault_item = node['screwdriver']['db_username_vault_item']
unless db_username_vault_item.empty?
  db_username = get_vault_item_value(db_username_vault_item)
  api_envs['DATASTORE_SEQUELIZE_USERNAME'] = '${DB_USERNAME}'
end

db_password = nil
db_password_vault_item = node['screwdriver']['db_password_vault_item']
unless db_password_vault_item.empty?
  db_password = get_vault_item_value(db_password_vault_item)
  api_envs['DATASTORE_SEQUELIZE_PASSWORD'] = '${DB_PASSWORD}'
end

db_root_password = nil
db_root_password_vault_item = node['screwdriver']['db_root_password_vault_item']
unless db_root_password_vault_item.empty?
  db_root_password = get_vault_item_value(db_root_password_vault_item)
end

db_dialect = api_envs_org['DATASTORE_SEQUELIZE_DIALECT']
case db_dialect
when 'sqlite'
  api_vols.push("#{data_dir}:/sd-data:rw")
  api_envs['DATASTORE_SEQUELIZE_STORAGE'] = '/sd-data/storage.db'
when 'mysql', 'postgres'
  override_config_srvs['api']['links'] = ['db']
  api_envs['DATASTORE_SEQUELIZE_HOST'] = 'db'
end

# db
if db_dialect != 'sqlite'
  #db_envs_org = config_srvs['db']['environment']
  db_envs = {}
  db_vols = config_srvs['db']['volumes'].to_a

  case db_dialect
  when 'mysql'
    mysql_data_dir = "#{data_dir}/mysql"
    resources(directory: mysql_data_dir) rescue directory mysql_data_dir do
      owner 999
      group 'docker'
      mode '0755'
      recursive true
    end

    db_vols.push("#{mysql_data_dir}:/var/lib/mysql:rw")
    db_envs['MYSQL_DATABASE'] = api_envs_org['DATASTORE_SEQUELIZE_DATABASE']
    db_envs['MYSQL_USER'] = '${DB_USERNAME}' unless db_username.nil?
    db_envs['MYSQL_PASSWORD'] = '${DB_PASSWORD}' unless db_password.nil?
    db_envs['MYSQL_ROOT_PASSWORD'] = '${DB_ROOT_PASSWORD}' unless db_root_password.nil?
  when 'postgres'
    pg_data_dir = "#{data_dir}/postgres"
    resources(directory: pg_data_dir) rescue directory pg_data_dir do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
    end

    db_vols.push("#{pg_data_dir}:/database:rw")
    db_envs['POSTGRES_DB'] = api_envs_org['DATASTORE_SEQUELIZE_DATABASE']
    db_envs['POSTGRES_USER'] = '${DB_USERNAME}' unless db_username.nil?
    db_envs['POSTGRES_PASSWORD'] = '${DB_PASSWORD}' unless db_password.nil?
    db_envs['PGDATA'] = '/database'
  end
end

# ui
#ui_envs_org = config_srvs['ui']['environment']
ui_envs = {}
ui_vols = config_srvs['ui']['volumes'].to_a

ui_port = '9000'  # default
ui_in_port = '80'
ports = config_srvs['ui']['ports']
if ports.empty?
  override_config_srvs['ui']['ports'] = ["#{ui_port}:#{ui_in_port}"]
else
  ports.each {|port|
    elms = port.split(':')
    ui_port = (elms.size == 2 ? elms[0] : elms[1]) if elms.last == ui_in_port
  }
end

# store
store_backend = node['screwdriver']['store']['backend']
store_envs_org = config_srvs['store']['environment']
store_envs = {}
store_vols = config_srvs['store']['volumes'].to_a

store_port = '9002'  # default
store_in_port = store_envs_org['PORT']
ports = config_srvs['store']['ports']
if ports.empty?
  override_config_srvs['store']['ports'] = ["#{store_port}:#{store_in_port}"]
else
  ports.each {|port|
    elms = port.split(':')
    store_port = (elms.size == 2 ? elms[0] : elms[1]) if elms.last == store_in_port
  }
end

s3_access_key_id = nil
s3_access_key_id_vault_item = node['screwdriver']['s3_access_key_id_vault_item']
unless s3_access_key_id_vault_item.empty?
  s3_access_key_id = get_vault_item_value(s3_access_key_id_vault_item)
  store_envs['S3_ACCESS_KEY_ID'] = '${S3_ACCESS_KEY_ID}'
end

s3_access_key_secret = nil
s3_access_key_secret_vault_item = node['screwdriver']['s3_access_key_secret_vault_item']
unless s3_access_key_secret_vault_item.empty?
  s3_access_key_secret = get_vault_item_value(s3_access_key_secret_vault_item)
  store_envs['S3_ACCESS_KEY_SECRET'] = '${S3_ACCESS_KEY_SECRET}'
end

# S3 compatible server
if !store_backend.nil? && !store_backend.empty?
  override_config_srvs['store']['links'] = ['screwdriver.s3']
  store_envs['STRATEGY'] = 's3'
  store_envs['S3_BUCKET'] = 'screwdriver'

  #s3_envs_org = config_srvs['screwdriver.s3']['environment']
  s3_envs = {}
  s3_vols = config_srvs['screwdriver.s3']['volumes'].to_a

  s3_port = '9010'  # default
  s3_in_port = '9000'
  ports = config_srvs['screwdriver.s3']['ports']

  case store_backend
  when 'minio'
    store_envs['S3_REGION'] = 'us-east-1'
    store_envs['S3_ENDPOINT'] = "http://s3:#{s3_in_port}/screwdriver"  # for path style
    store_envs['S3_SIG_VER'] = 'v4'

    if ports.empty?
      override_config_srvs['screwdriver.s3']['ports'] = ["#{s3_port}:#{s3_in_port}"]
    else
      ports.each {|port|
        elms = port.split(':')
        s3_port = (elms.size == 2 ? elms[0] : elms[1]) if elms.last == s3_in_port
      }
    end

    minio_data_dir = "#{data_dir}/minio"
    resources(directory: minio_data_dir) rescue directory minio_data_dir do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
    end

    s3_vols.push("#{minio_data_dir}:/export:rw")
    s3_envs['MINIO_ACCESS_KEY'] = '${S3_ACCESS_KEY_ID}' unless s3_access_key_id.nil?
    s3_envs['MINIO_SECRET_KEY'] = '${S3_ACCESS_KEY_SECRET}' unless s3_access_key_secret.nil?
  end
end

override_store_config['auth']['jwtPublicKey'] = jwt_public_key
# Note: prevent Chef from logging JWT key attribute value. (=> template variables)
# However Docker env file format does not support multi-line value and backslash escaped string yet.
#store_envs['SECRET_JWT_PUBLIC_KEY'] = '${SECRET_JWT_PUBLIC_KEY}'  # Useless
#store_envs['SECRET_JWT_PUBLIC_KEY']  = jwt_public_key  # NG

api_uri = api_envs_org['URI']
store_uri = store_envs_org['URI']
ui_uri = api_uri.gsub(/:\d+/, ":#{ui_port}")  # based on the API URI.

if node['screwdriver']['with_ssl_cert_cookbook']
  cn = node['screwdriver']['ssl_cert']['common_name']
  append_server_ssl_cn(cn)
  include_recipe 'ssl_cert::server_key_pairs'

  server_cert = server_cert_content(cn)
  server_key = server_key_content(cn)

  api_uri = api_uri.gsub('http://', 'https://')
  store_uri = store_uri.gsub('http://', 'https://')

  override_api_config['httpd']['tls'] = {}  # for FalseClass by default.
  override_api_config['httpd']['tls']['cert'] = server_cert
  override_api_config['httpd']['tls']['key'] = server_key
  api_envs['IS_HTTPS'] = 'true'

  override_store_config['httpd']['tls'] = {}  # for FalseClass by default.
  override_store_config['httpd']['tls']['cert'] = server_cert
  override_store_config['httpd']['tls']['key'] = server_key

  # Note: Screwdriver UI image does not support TLS settings yet.
  # https://github.com/screwdriver-cd/screwdriver/issues/377

  if node['screwdriver']['ui']['tls_setup_mode'] == 'reverseproxy'
    rproxy_in_port = '9000'
    ports = config_srvs['reverseproxy']['ports']
    if ports.empty?
      override_config_srvs['reverseproxy']['ports'] = ["#{ui_port}:#{rproxy_in_port}"]
    else
      ports.each {|port|
        elms = port.split(':')
        ui_port = (elms.size == 2 ? elms[0] : elms[1]) if elms.last == rproxy_in_port
      }
    end
    ui_uri = api_uri.gsub(/:\d+/, ":#{ui_port}")  # based on the API URI.
    # do not expose UI service directly.
    node.rm('screwdriver', 'docker-compose', 'config', 'services', 'ui', 'ports')

    rproxy_vols = config_srvs['reverseproxy']['volumes'].to_a
    rproxy_vols.push("#{etc_dir}/nginx/nginx.conf:/etc/nginx/nginx.conf:ro")
    # Nginx parent process owner is root.
    rproxy_vols.push("#{server_cert_path(cn)}:/root/server.crt:ro")
    rproxy_vols.push("#{server_key_path(cn)}:/root/server.key:ro")
    # reset vlumes array.
    override_config_srvs['reverseproxy']['volumes'] = rproxy_vols

    template "#{etc_dir}/nginx/nginx.conf" do
      source 'opt/docker-compose/app/screwdriver/etc/nginx/nginx.conf'
      owner 'root'
      group 'root'
      mode '0644'
      action :create
    end
  else
    node.rm('screwdriver', 'docker-compose', 'config', 'services', 'reverseproxy')
    # TODO: in the future.
  end
else
  node.rm('screwdriver', 'docker-compose', 'config', 'services', 'reverseproxy')
end

# normalize URIs
api_envs['URI'] = api_uri
api_envs['ECOSYSTEM_STORE'] = store_uri
api_envs['ECOSYSTEM_UI'] = ui_uri

ui_envs['ECOSYSTEM_API'] = api_uri
ui_envs['ECOSYSTEM_STORE'] = store_uri

store_envs['URI'] = store_uri
store_envs['ECOSYSTEM_UI'] = ui_uri

# Common
if node['screwdriver']['docker-compose']['import_ca']
  node['screwdriver']['ssl_cert']['ca_names'].each {|ca_name|
    append_ca_name(ca_name)
    ca_cert_vol = "#{ca_cert_path(ca_name)}:/usr/share/ca-certificates/#{ca_name}.crt:ro"
    api_vols.push(ca_cert_vol)
    #ui_vols.push(ca_cert_vol)
  }
  include_recipe 'ssl_cert::ca_certs'

  import_ca_script = '/usr/local/bin/screwdriver_import_ca'
  template "#{bin_dir}/screwdriver_import_ca" do
    source 'opt/docker-compose/app/screwdriver/bin/screwdriver_import_ca'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
  import_ca_script_vol = "#{bin_dir}/screwdriver_import_ca:#{import_ca_script}:ro"
  api_vols.push(import_ca_script_vol)
  #ui_vols.push(import_ca_script_vol)

  api_command = config_srvs['api']['command']
  override_config_srvs['api']['command'] \
    = "/bin/sh -c \"#{import_ca_script} && #{api_command}\""
end

[
  'api',
  'store',
].each {|srv|
  local_yaml_file = "#{config_dir}/#{srv}-local.yaml"
  srv_vols = nil
  srv_config = nil
  if srv == 'api'
    srv_vols = api_vols
    srv_config = override_api_config
  elsif srv == 'store'
    srv_vols = store_vols
    srv_config = override_store_config
  end

  template local_yaml_file do
    source "opt/docker-compose/app/screwdriver/config/#{srv}-local.yaml"
    owner 'root'
    group 'root'
    mode '0600'
    sensitive true
    # prevent Chef from logging password attribute value.
    variables(
      config: srv_config
    )
  end

  srv_vols.push("#{local_yaml_file}:/config/local.yaml:ro")
}

# merge environment hash
force_override_config_srvs['api']['environment'] = api_envs unless api_envs.empty?
force_override_config_srvs['ui']['environment'] = ui_envs unless ui_envs.empty?
force_override_config_srvs['store']['environment'] = store_envs unless store_envs.empty?
if db_dialect != 'sqlite'
  force_override_config_srvs['db']['environment'] = db_envs unless db_envs.empty?
end
if !store_backend.nil? && !store_backend.empty?
  force_override_config_srvs['screwdriver.s3']['environment'] = s3_envs unless s3_envs.empty?
end
# reset vlumes array.
override_config_srvs['api']['volumes'] = api_vols unless api_vols.empty?
override_config_srvs['ui']['volumes'] = ui_vols unless ui_vols.empty?
override_config_srvs['store']['volumes'] = store_vols unless store_vols.empty?
if db_dialect != 'sqlite'
  override_config_srvs['db']['volumes'] = db_vols unless db_vols.empty?
end
if !store_backend.nil? && !store_backend.empty?
  override_config_srvs['screwdriver.s3']['volumes'] = s3_vols unless s3_vols.empty?
end

template env_file do
  source 'opt/docker-compose/app/screwdriver/.env'
  owner 'root'
  group 'root'
  mode '0600'
  sensitive true
  # prevent Chef from logging password attribute value.
  variables(
    # secrets
    cookie_password: cookie_password,
    password: password,
    db_username: db_username,
    db_password: db_password,
    db_root_password: db_root_password,
    s3_access_key_id: s3_access_key_id,
    s3_access_key_secret: s3_access_key_secret,
    # **DEPRECATED!!**
    # JWT keys setting -> /config/local.yaml
    #jwt_private_key: jwt_private_key,
    #jwt_public_key: jwt_public_key,
    # SCM secrets setting -> /config/local.yaml
    #oauth_client_id: oauth_client_id,
    #oauth_client_secret: oauth_client_secret,
    #webhook_github_secret: webhook_github_secret
  )
end

template config_file do
  source 'opt/docker-compose/app/screwdriver/docker-compose.yml'
  owner 'root'
  group 'root'
  mode '0644'
end

log 'screwdriver docker-compose post install message' do
  message <<-"EOM"
Note: You must execute the following command manually.
    See #{doc_url}
    * Start:
      $ cd #{app_dir}
      $ sudo docker-compose up -d
    * Stop
      $ sudo docker-compose down
EOM
end
