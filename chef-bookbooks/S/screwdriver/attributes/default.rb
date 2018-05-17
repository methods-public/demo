#
# Cookbook Name:: screwdriver
# Attributes:: default
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

default['screwdriver']['with_ssl_cert_cookbook'] = false
# If ['screwdriver']['with_ssl_cert_cookbook'] is true,
# node['screwdriver']['docker-compose']['config']
# are overridden by the following 'common_name' attributes.
default['screwdriver']['ssl_cert']['ca_names'] = []
default['screwdriver']['ssl_cert']['common_name'] = node['fqdn']
cn = node['screwdriver']['ssl_cert']['common_name']
cn = node['ipaddress'] if cn.nil? || cn.empty?

default['screwdriver']['jwt_private_key_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'jwt_private_key',
  # single secret or nested hash secret path delimited by slash
  'env_context' => false,
  'key' => 'private',  # real hash path: "/private"
  # or nested hash secret path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/private',  # real hash path: "/#{node.chef_environment}/hash/path/to/private"
=end
}
default['screwdriver']['jwt_public_key_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'jwt_public_key',
  # single secret or nested hash secret path delimited by slash
  'env_context' => false,
  'key' => 'public',  # real hash path: "/public"
  # or nested hash secret path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/public',  # real hash path: "/#{node.chef_environment}/hash/path/to/public"
=end
}
# A password used for encrypting session data. Needs to be minimum 32 characters
default['screwdriver']['cookie_password_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'cookie_password',
  # single password or nested hash password path delimited by slash
  'env_context' => false,
  'key' => 'password',  # real hash path: "/password"
  # or nested hash password path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/password',  # real hash path: "/#{node.chef_environment}/hash/path/to/password"
=end
}
# A password used for encrypting stored secrets. Needs to be minimum 32 characters
default['screwdriver']['password_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'password',
  # single password or nested hash password path delimited by slash
  'env_context' => false,
  'key' => 'password',  # real hash path: "/password"
  # or nested hash password path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/password',  # real hash path: "/#{node.chef_environment}/hash/path/to/password"
=end
}
default['screwdriver']['db_username_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'db_username',
  # single usernaem or nested hash username path delimited by slash
  'env_context' => false,
  'key' => 'username',  # real hash path: "/username"
  # or nested hash username path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/username',  # real hash path: "/#{node.chef_environment}/hash/path/to/username"
=end
}
default['screwdriver']['db_password_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'db_password',
  # single password or nested hash password path delimited by slash
  'env_context' => false,
  'key' => 'password',  # real hash path: "/password"
  # or nested hash password path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/password',  # real hash path: "/#{node.chef_environment}/hash/path/to/password"
=end
}
default['screwdriver']['db_root_password_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'db_root_password',
  # single password or nested hash password path delimited by slash
  'env_context' => false,
  'key' => 'password',  # real hash path: "/password"
  # or nested hash password path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/password',  # real hash path: "/#{node.chef_environment}/hash/path/to/password"
=end
}
default['screwdriver']['s3_access_key_id_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 's3_access_key',
  # single key id or nested hash key id path delimited by slash
  'env_context' => false,
  'key' => 'kid',  # real hash path: "/kid"
  # or nested hash key id path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/kid',  # real hash path: "/#{node.chef_environment}/hash/path/to/kid"
=end
}
default['screwdriver']['s3_access_key_secret_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 's3_access_key',
  # single secret or nested hash secret path delimited by slash
  'env_context' => false,
  'key' => 'secret',  # real hash path: "/secret"
  # or nested hash secret path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/secret',  # real hash path: "/#{node.chef_environment}/hash/path/to/secret"
=end
}

force_override['screwdriver']['ui']['tls_setup_mode'] = 'reverseproxy'
# These hash objects are expanded to a `/config/local.yaml` file in each Docker container.
default['screwdriver']['api']['config'] = {
  'auth' => {},
  'httpd' => {
    'tls' => false,
  },
  'executor' => {
=begin
    # default
    'plugin' => 'docker',
    'docker' => {
      'options' => {
        'docker' => {
          'socketPath' => '/var/run/docker.sock',
        },
        'launchVersion' => 'stable',
      },
    },
=end
  },
  'scms' => {
=begin
    'scm_a' => {  # id and display name
      'plugin' => 'github',
      'config' => {
        # These 3 secrets should be set by the following `['screwdriver']['api']['scms_vault_items']` attribute.
        'oauthClientId' => 'YOU-PROBABLY-WANT-SOMETHING-HERE',  # The client id used for OAuth with github. GitHub OAuth (https://developer.github.com/v3/oauth/)
        'oauthClientSecret' => 'AGAIN-SOMETHING-HERE-IS-USEFUL',  # The client secret used for OAuth with github
        'secret' => 'SUPER-SECRET-SIGNING-THING',  # Secret to add to GitHub webhooks so that we can validate them
        'gheHost' => 'github.screwdriver.cd',  # [Optional] GitHub enterprise host
        'username' => 'sd-buildbot',  # [Optional] Username for code checkout
        'email' => 'dev-null@screwdriver.cd',  # [Optional] Email for code checkout
        'privateRepo' => false,  # [Optional] Set to true to support private repo; will need read and write access to public and private repos (https://developer.github.com/v3/oauth/#scopes)
      },
    },
    'scm_b' => {  # id and display name
      'plugin' => 'bitbucket',
      'config' => {
        'oauthClientId' => 'YOUR-APP-KEY',
        'oauthClientSecret' => 'YOUR-APP-SECRET',
      },
    },
=end
  },
}
default['screwdriver']['api']['scms_vault_items'] = {
=begin
  'scm_a' => {
    'oauthClientId' => {
      'vault' => 'screwdriver',
      'name' => 'scm_a',
      # single oauthClientId or nested hash oauthClientId path delimited by slash
      'env_context' => false,
      'key' => 'oauthClientId',  # real hash path: "/oauthClientId", Note: do not use `id`, which is preserved by Chef Vault.
      # or nested hash id path delimited by slash
      #'env_context' => true,
      #'key' => 'hash/path/to/oauthClientId',  # real hash path: "/#{node.chef_environment}/hash/path/to/oauthClientId"
    },
    'oauthClientSecret' => {
      'vault' => 'screwdriver',
      'name' => 'scm_a',
      # single oauthClientSecret or nested hash oauthClientSecret path delimited by slash
      'env_context' => false,
      'key' => 'oauthClientSecret',  # real hash path: "/oauthClientSecret"
      # or nested hash secret path delimited by slash
      #'env_context' => true,
      #'key' => 'hash/path/to/oauthClientSecret',  # real hash path: "/#{node.chef_environment}/hash/path/to/oauthClientSecret"
    },
    # GitHub only.
    'secret' => {
      'vault' => 'screwdriver',
      'name' => 'scm_a',
      # single secret or nested hash secret path delimited by slash
      'env_context' => false,
      'key' => 'secret',  # real hash path: "/secret"
      # or nested hash password path delimited by slash
      #'env_context' => true,
      #'key' => 'hash/path/to/secret',  # real hash path: "/#{node.chef_environment}/hash/path/to/secret"
    },
  },
  'scm_b' => {
    # ...
  },
  # ...
=end
}

default['screwdriver']['store']['backend'] = nil  # or 'minio'
default['screwdriver']['store']['config'] = {
  'auth' => {},
  'httpd' => {
    'tls' => false,
  },
=begin
  # for Minio
  'strategy' => {
    'plugin' => 's3',
    's3' => {
      'accessKeyId' => '',
      'secretAccessKey' => '****************************************',
      'region' => 'us-east-1',
      'bucket' => 'screwdriver',
      'endpoint' => 'http://s3:9000/screwdriver',
      'signatureVersion' => 'v4',
    },
  },
=end
}

# Useless?!
force_override['screwdriver']['docker-compose']['import_ca'] = false
default['screwdriver']['docker-compose']['app_dir'] = "#{node['docker-grid']['compose']['app_dir']}/screwdriver"
default['screwdriver']['docker-compose']['bin_dir'] = "#{node['screwdriver']['docker-compose']['app_dir']}/bin"
default['screwdriver']['docker-compose']['config_dir'] = "#{node['screwdriver']['docker-compose']['app_dir']}/config"
default['screwdriver']['docker-compose']['data_dir'] = "#{node['screwdriver']['docker-compose']['app_dir']}/data"
default['screwdriver']['docker-compose']['etc_dir'] = "#{node['screwdriver']['docker-compose']['app_dir']}/etc"
default['screwdriver']['docker-compose']['jwt_private_key_reset'] = false

# **DEPRECATED**: use ['screwdriver']['(jwt|cookie|password)_*_vault_item'] attributes.
default['screwdriver']['docker-compose']['jwt_private_key_vault_item'] = {}
default['screwdriver']['docker-compose']['jwt_public_key_vault_item'] = {}
default['screwdriver']['docker-compose']['cookie_password_vault_item'] = {}
default['screwdriver']['docker-compose']['password_vault_item'] = {}

# **DEPRECATED**: use the above `['screwdriver']['api']['scms_vault_items']` attribute.
default['screwdriver']['docker-compose']['oauth_client_id_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'oauth_client_id',
  # single cid or nested hash cid path delimited by slash
  'env_context' => false,
  'key' => 'cid',  # real hash path: "/cid", Note: do not use `id`, which is preserved by Chef Vault.
  # or nested hash id path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/cid',  # real hash path: "/#{node.chef_environment}/hash/path/to/cid"
=end
}
# **DEPRECATED**: use the above `['screwdriver']['api']['scms_vault_items']` attribute.
default['screwdriver']['docker-compose']['oauth_client_secret_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'oauth_client_secret',
  # single secret or nested hash secret path delimited by slash
  'env_context' => false,
  'key' => 'secret',  # real hash path: "/secret"
  # or nested hash secret path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/secret',  # real hash path: "/#{node.chef_environment}/hash/path/to/secret"
=end
}
# **DEPRECATED**: use the above `['screwdriver']['api']['scms_vault_items']` attribute.
default['screwdriver']['docker-compose']['webhook_github_secret_vault_item'] = {
=begin
  'vault' => 'screwdriver',
  'name' => 'webhook_github_secret',
  # single password or nested hash password path delimited by slash
  'env_context' => false,
  'key' => 'secret',  # real hash path: "/secret"
  # or nested hash password path delimited by slash
  #'env_context' => true,
  #'key' => 'hash/path/to/secret',  # real hash path: "/#{node.chef_environment}/hash/path/to/secret"
=end
}

# ref: https://github.com/screwdriver-cd/screwdriver/blob/master/in-a-box.py
force_override['screwdriver']['docker-compose']['config_format_version'] = '2'
version_2_config = {
  # Version 2 docker-compose format
  'version' => '2',
  'services' => {
    # this service will be active if the `['screwdriver']['with_ssl_cert_cookbook']` attribute is true.
    'reverseproxy' => {
      'depends_on' => [
        'ui',
      ],
      'restart' => 'always',
      'image' => 'nginx:alpine',
      'expose' => [
        '9000',
      ],
      'ports' => [
        #'9000:9000',  # default
      ],
      'volumes' => [
        # This volume will be set by the screwdriver::docker-compose recipe automatically.
        #"#{node['screwdriver']['docker-compose']['etc_dir']}/nginx/nginx.conf:/etc/nginx/nginx.conf:ro",
      ],
    },
    'api' => {
      'image' => 'screwdrivercd/screwdriver:latest',
      'command' => 'npm start',  # the original command in the Dockerfile.
      'ports' => [
        #'9001:80',  # default
      ],
      'volumes' => [
        '/var/run/docker.sock:/var/run/docker.sock:rw',
        # This volume will be set by the screwdriver::docker-compose recipe automatically.
        #"#{node['screwdriver']['docker-compose']['data_dir']}:/sd-data:rw",  # for sqlite
      ],
      'environment' => {
        # See:
        # http://docs.screwdriver.cd/cluster-management/configure-api
        # https://github.com/screwdriver-cd/screwdriver/blob/master/config/custom-environment-variables.yaml
        'PORT' => '80',
        'URI' => "http://#{cn}:9001",
        #'URI' => "http://#{node['ipaddress']}:9001",  # unrecommended
        # These vriables will be set by the screwdriver::docker-compose recipe automatically.
        #'ECOSYSTEM_UI' => "http://#{cn}:9000",                 # Better
        #'ECOSYSTEM_UI' => "http://#{node['ipaddress']}:9000",  # unrecommended
        #'ECOSYSTEM_UI' => 'http://ui',                         # NG: for an access from a client.
        #'ECOSYSTEM_STORE' => "http://#{cn}:9002",                 # Better
        #'ECOSYSTEM_STORE' => "http://#{node['ipaddress']}:9002",  # unrecommended
        #'ECOSYSTEM_STORE' => 'http://store',
        'SECRET_WHITELIST' => '[]',
        'SECRET_ADMINS' => '[]',
        'DATASTORE_PLUGIN' => 'sequelize',
        'DATASTORE_SEQUELIZE_DATABASE' => 'screwdriver',
        'DATASTORE_SEQUELIZE_DIALECT' => 'sqlite',
        # This variable will be set by the screwdriver::docker-compose recipe automatically.
        #'DATASTORE_SEQUELIZE_STORAGE' => '/sd-data/storage.db',
        # for MySQL
        #'DATASTORE_SEQUELIZE_DIALECT' => 'mysql',
        # These variables will be set by the screwdriver::docker-compose recipe automatically.
        #'DATASTORE_SEQUELIZE_USERNAME' => '${DB_USERNAME}',
        #'DATASTORE_SEQUELIZE_PASSWORD' => '${DB_PASSWORD}',
        #'DATASTORE_SEQUELIZE_HOST' => 'db',
        # This variable will be set by the screwdriver::docker-compose recipe automatically.
        #'IS_HTTPS' => 'false',
        #'NODE_TLS_REJECT_UNAUTHORIZED' => '0',  # workaround for self-signed cetificates
=begin
        # **DEPRECATED**: use the `['screwdriver']['api']['config']['executor']` attribute.
        'EXECUTOR_PLUGIN' => 'docker',
        'EXECUTOR_DOCKER_DOCKER' => <<-'EOS',
{
  "socketPath": "/var/run/docker.sock"
}
EOS
=end
=begin
        # SCM settings
        # **DEPRECATED**: Please use the above `['screwdriver']['api']['config']['scms']` attribute
        # instead of `SCM_SETTINGS` env. variable.
        # 'SCM_SETTINGS' => '{}',
        #
        # **DEPRECATED**: Non-Multiple SCMs setting format.
        #   - Note: Multiple SCMs not supported yet.
        #     https://github.com/screwdriver-cd/screwdriver/issues/365
        #   - OAuth Callback URL: "http://#{cn}:9001/v4/auth/login/web"
        'SCM_PLUGIN' => 'github',  # or 'gitlab' or 'bitbucket'
        # * Commons
        'SCM_USERNAME' => 'sd-buildbot',
        'SCM_EMAIL' => 'dev-null@screwdriver.cd',
        # The following variables will be set by the screwdriver::docker-compose recipe automatically.
        'SECRET_OAUTH_CLIENT_ID' => '${SECRET_OAUTH_CLIENT_ID}',
        'SECRET_OAUTH_CLIENT_SECRET' => '${SECRET_OAUTH_CLIENT_SECRET}',
        # * GitHub only
        'WEBHOOK_GITHUB_SECRET' => '${WEBHOOK_GITHUB_SECRET}',  #'SUPER-SECRET-SIGNING-THING'
        'SCM_GITHUB_GHE_HOST' => 'gitlab.io.example.com',  # for GHE
        'SCM_PRIVATE_REPO_SUPPORT' => 'false',
        # * GitLab only
        #'SCM_GITLAB_HOST' => 'gitlab.io.example.com',
        #'SCM_GITLAB_PROTOCOL' => 'https',
        # * Bitbucket only
        #   None.
=end
      },
    },
    'ui' => {
      'image' => 'screwdrivercd/ui:latest',
      'ports' => [
        #'9000:80',  # default
      ],
      'environment' => {
        # These variables will be set by the screwdriver::docker-compose recipe automatically.
        #'ECOSYSTEM_API' => 'http://api',                        # NG: for an access from a client.
        #'ECOSYSTEM_API' => "http://#{cn}:9001",                 # Better
        #'ECOSYSTEM_API' => "http://#{node['ipaddress']}:9001",  # unrecommended
        #'ECOSYSTEM_STORE' => 'http://store',
        #'ECOSYSTEM_STORE' => "http://#{cn}:9002",                 # Better
        #'ECOSYSTEM_STORE' => "http://#{node['ipaddress']}:9002",  # unrecommended
      },
    },
    'store' => {
      'image' => 'screwdrivercd/store:latest',
      'ports' => [
        #'9002:80',  # default
      ],
      'environment' => {
        # See https://github.com/screwdriver-cd/store/blob/master/config/custom-environment-variables.yaml
        'PORT' => '80',
        'URI' => "http://#{cn}:9002",
        #'URI' => "http://#{node['ipaddress']}:9002",  # unrecommended
        # These variables will be set by the screwdriver::docker-compose recipe automatically.
        #'ECOSYSTEM_UI' => "http://#{cn}:9000",  # Better
        #'ECOSYSTEM_UI' => "http://#{node['ipaddress']}:9000",
        #'ECOSYSTEM_UI' => 'http://ui',          # NG for an access from a client.
        #'STRATEGY' => 'memory',  # default
        # * AWS S3
        #'STRATEGY' => 's3',
        # If node['screwdriver']['s3_access_key_{id,secret}_vault_item'] is set,
        # these 2 variables will be set by the screwdriver::docker-compose recipe automatically.
        #'S3_ACCESS_KEY_ID' => '${S3_ACCESS_KEY_ID}',
        #'S3_ACCESS_KEY_SECRET' => '${S3_ACCESS_KEY_SECRET}',
        #'S3_REGION' => 'us-east-1',
        #'S3_BUCKET' => 'screwdriver',
        # * Minio
        # If node['screwdriver']['store']['backend'] is 'minio',
        # these variables will be set by the screwdriver::docker-compose recipe automatically.
        #'STRATEGY' => 's3',
        #'S3_ACCESS_KEY_ID' => '${S3_ACCESS_KEY_ID}',
        #'S3_ACCESS_KEY_SECRET' => '${S3_ACCESS_KEY_SECRET}',
        #'S3_REGION' => 'us-east-1',
        #'S3_BUCKET' => 'screwdriver',
        #'S3_ENDPOINT' => 'http://s3:9000/screwdriver',  # tricky!! setting for the S3 virtual hosting style.
        #'S3_SIG_VER' => 'v4',
      },
      # for S3 compatible server
      #'links' => [
      #  'screwdriver.s3',
      #],
    },
  },
}

config_srvs = node['screwdriver']['docker-compose']['config']['services']
case config_srvs['api']['environment']['DATASTORE_SEQUELIZE_DIALECT']
when 'mysql'
  version_2_config['services']['db'] = {
    'image' => 'mysql:5',
    'volumes' => [
      # This variable will be set by the screwdriver::docker-compose recipe automatically.
      #"#{node['screwdriver']['docker-compose']['data_dir']}/mysql:/var/lib/mysql:rw",
    ],
    'environment' => {
      # These variables will be set by the screwdriver::docker-compose recipe automatically.
      #'MYSQL_ROOT_PASSWORD' => '${DB_ROOT_PASSWORD}',
      #'MYSQL_USER' => '${DB_USERNAME}',
      #'MYSQL_PASSWORD' => '${DB_PASSWORD}',
      #'MYSQL_DATABASE' => 'screwdriver',
    },
  }
when 'postgres'
  version_2_config['services']['db'] = {
    'image' => 'postgres:9',
    'volumes' => [
      # This variable will be set by the screwdriver::docker-compose recipe automatically.
      #"#{node['screwdriver']['docker-compose']['data_dir']}/postgres:/database:rw",
    ],
    'environment' => {
      # These variables will be set by the screwdriver::docker-compose recipe automatically.
      #'POSTGRES_USER' => '${DB_USERNAME}',
      #'POSTGRES_PASSWORD' => '${DB_PASSWORD}',
      #'POSTGRES_DB' => 'screwdriver',
      #'PGDATA' => '/database',
    },
  }
end

# S3 compatible server
case node['screwdriver']['store']['backend']
when 'minio'
  version_2_config['services']['screwdriver.s3'] = {
    'image' => 'minio/minio',
    'ports' => [
      #'9010:9000',  # default
    ],
    'command' => 'server /export',
    'volumes' => [
      # This variable will be set by the screwdriver::docker-compose recipe automatically.
      #"#{node['screwdriver']['docker-compose']['data_dir']}//minio:/export:rw",
    ],
    'environment' => {
      # These variables will be set by the screwdriver::docker-compose recipe automatically.
      #'MINIO_ACCESS_KEY' => '${S3_ACCESS_KEY_ID}',
      #'MINIO_SECRET_KEY' => '${S3_ACCESS_KEY_SECRET}',
    },
  }
end

default['screwdriver']['docker-compose']['config'] = version_2_config
