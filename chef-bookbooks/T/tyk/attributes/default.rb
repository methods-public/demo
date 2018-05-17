# Gateway
default['tyk']['gateway']['install_path'] = '/opt/tyk-gateway'

# Gateway configuration
# The configuration file is generated from node['tyk']['gateway']['config']
# For documentation see https://tyk.io/docs/tyk-api-gateway-v-2-0/configuration/gateway-configuration-options/
default['tyk']['gateway']['config']['listen_port'] = 8080
default['tyk']['gateway']['config']['secret'] = 'Y0uSh0u1dR3a11yChang3Th1sS3cr3t'
default['tyk']['gateway']['config']['node_secret'] = node['tyk']['gateway']['config']['secret']
default['tyk']['gateway']['config']['template_path'] = "#{node['tyk']['gateway']['install_path']}/templates"
default['tyk']['gateway']['config']['tyk_js_path'] = "#{node['tyk']['gateway']['install_path']}/js/tyk.js"
default['tyk']['gateway']['config']['use_db_app_configs'] = false
default['tyk']['gateway']['config']['app_path'] = "#{node['tyk']['gateway']['install_path']}/apps"
default['tyk']['gateway']['config']['middleware_path'] = "#{node['tyk']['gateway']['install_path']}/middleware"
default['tyk']['gateway']['config']['storage']
default['tyk']['gateway']['config']['storage']['type'] = 'redis'
default['tyk']['gateway']['config']['storage']['host'] = 'localhost'
default['tyk']['gateway']['config']['storage']['port'] = 6379
default['tyk']['gateway']['config']['storage']['username'] = ''
default['tyk']['gateway']['config']['storage']['password'] = ''
default['tyk']['gateway']['config']['storage']['database'] = 0
default['tyk']['gateway']['config']['storage']['optimisation_max_idle'] = 500
default['tyk']['gateway']['config']['storage']['optimisation_max_active'] = 800
default['tyk']['gateway']['config']['enable_analytics'] = false
default['tyk']['gateway']['config']['enable_detailed_recording'] = false
default['tyk']['gateway']['config']['enable_geo_ip'] = false
default['tyk']['gateway']['config']['analytics_config']['ignored_ips'] = []
default['tyk']['gateway']['config']['health_check']
default['tyk']['gateway']['config']['health_check']['enable_health_checks'] = true
default['tyk']['gateway']['config']['health_check']['health_check_value_timeouts'] = 60
default['tyk']['gateway']['config']['optimisations_use_async_session_write'] = true
default['tyk']['gateway']['config']['allow_master_keys'] = false
default['tyk']['gateway']['config']['policies']
default['tyk']['gateway']['config']['policies']['policy_source'] = 'file'
default['tyk']['gateway']['config']['policies']['policy_record_name'] = 'policies'
default['tyk']['gateway']['config']['hash_keys'] = true
default['tyk']['gateway']['config']['suppress_redis_signal_reload'] = false
default['tyk']['gateway']['config']['close_connections'] = true
default['tyk']['gateway']['config']['local_session_cache']
default['tyk']['gateway']['config']['local_session_cache']['disable_cached_session_state'] = true
default['tyk']['gateway']['config']['uptime_tests']
default['tyk']['gateway']['config']['uptime_tests']['disable'] = false
default['tyk']['gateway']['config']['uptime_tests']['config']
default['tyk']['gateway']['config']['uptime_tests']['config']['enable_uptime_analytics'] = false
default['tyk']['gateway']['config']['uptime_tests']['config']['failure_trigger_sample_size'] = 3
default['tyk']['gateway']['config']['uptime_tests']['config']['time_wait'] = 300
default['tyk']['gateway']['config']['uptime_tests']['config']['checker_pool_size'] = 50
default['tyk']['gateway']['config']['hostname'] = 'tyk.local'
default['tyk']['gateway']['config']['enable_custom_domains'] = true
default['tyk']['gateway']['config']['enable_jsvm'] = true

# Dashboard
default['tyk']['dashboard']['install_path'] = '/opt/tyk-dashboard'

# Dashboard configuration
# The configuration file is generated from node['tyk']['dashboard']['config']
# For documentation see https://tyk.io/docs/tyk-dashboard-v1-0/configuration/
default['tyk']['dashboard']['config']['listen_port'] = 3000
default['tyk']['dashboard']['config']['tyk_api_config']['Host'] = 'http://localhost'
default['tyk']['dashboard']['config']['tyk_api_config']['Port'] = node['tyk']['gateway']['config']['listen_port'].to_s
default['tyk']['dashboard']['config']['tyk_api_config']['Secret'] = node['tyk']['gateway']['config']['secret']
default['tyk']['dashboard']['config']['mongo_url'] = 'mongodb://127.0.0.1/tyk_analytics'
default['tyk']['dashboard']['config']['shared_node_secret'] = node['tyk']['gateway']['config']['node_secret']
default['tyk']['dashboard']['config']['page_size'] = 10
default['tyk']['dashboard']['config']['admin_secret'] = '12345'
default['tyk']['dashboard']['config']['redis_port'] = node['tyk']['gateway']['config']['storage']['port']
default['tyk']['dashboard']['config']['redis_host'] = node['tyk']['gateway']['config']['storage']['host']
default['tyk']['dashboard']['config']['redis_database'] = node['tyk']['gateway']['config']['storage']['database']
default['tyk']['dashboard']['config']['redis_password'] = node['tyk']['gateway']['config']['storage']['password']
default['tyk']['dashboard']['config']['force_api_defaults'] = false
default['tyk']['dashboard']['config']['notify_on_change'] = true
default['tyk']['dashboard']['config']['license_owner'] = 'Your Name'
default['tyk']['dashboard']['config']['hash_keys'] = node['tyk']['gateway']['config']['hash_keys']
default['tyk']['dashboard']['config']['email_backend'] = {}
default['tyk']['dashboard']['config']['hide_listen_path'] = false
default['tyk']['dashboard']['config']['use_sentry'] = false
default['tyk']['dashboard']['config']['sentry_code'] = ''
default['tyk']['dashboard']['config']['sentry_js_code'] = ''
default['tyk']['dashboard']['config']['show_org_id'] = true
default['tyk']['dashboard']['config']['enable_duplicate_slugs'] = true
default['tyk']['dashboard']['config']['host_config']['override_hostname'] = node['fqdn']
default['tyk']['dashboard']['config']['host_config']['disable_org_slug_prefix'] = true
default['tyk']['dashboard']['config']['host_config']['enable_host_names'] = false
default['tyk']['dashboard']['config']['host_config']['hostname'] = node['fqdn']
default['tyk']['dashboard']['config']['host_config']['portal_domains'] = {}
default['tyk']['dashboard']['config']['host_config']['portal_root_path'] = '/portal'
default['tyk']['dashboard']['config']['http_server_options']['use_ssl'] = false
default['tyk']['dashboard']['config']['http_server_options']['certificates'] = [{}]
default['tyk']['dashboard']['config']['ui']['login_page'] = {}
default['tyk']['dashboard']['config']['ui']['nav'] = {}
default['tyk']['dashboard']['config']['ui']['uptime'] = {}
default['tyk']['dashboard']['config']['ui']['portal'] = {}
default['tyk']['dashboard']['config']['ui']['designer'] = {}
default['tyk']['dashboard']['config']['home_dir'] = node['tyk']['dashboard']['install_path']
default['tyk']['dashboard']['config']['identity_broker']['enabled'] = false

# Pump
default['tyk']['pump']['install_path'] = '/opt/tyk-pump'

# Pump configuration
# The configuration file is generated from node['tyk']['pump']['config']
# For documentation see https://tyk.io/docs/tyk-pump/configuration/
default['tyk']['pump']['config']['analytics_storage_type'] = 'redis'
default['tyk']['pump']['config']['analytics_storage_config']['type'] = 'redis'
default['tyk']['pump']['config']['analytics_storage_config']['host'] = node['tyk']['gateway']['config']['storage']['host']

default['tyk']['pump']['config']['analytics_storage_config']['port'] = node['tyk']['gateway']['config']['storage']['port']

default['tyk']['pump']['config']['analytics_storage_config']['hosts'] = nil
default['tyk']['pump']['config']['analytics_storage_config']['username'] = node['tyk']['gateway']['config']['storage']['username']
default['tyk']['pump']['config']['analytics_storage_config']['password'] = node['tyk']['gateway']['config']['storage']['password']

default['tyk']['pump']['config']['analytics_storage_config']['database'] = node['tyk']['gateway']['config']['storage']['database']

default['tyk']['pump']['config']['analytics_storage_config']['optimisation_max_idle'] = 100
default['tyk']['pump']['config']['analytics_storage_config']['optimisation_max_active'] = 0
default['tyk']['pump']['config']['analytics_storage_config']['enable_cluster'] = false
default['tyk']['pump']['config']['purge_delay'] = 10
default['tyk']['pump']['config']['uptime_pump_config']['collection_name'] = 'tyk_uptime_analytics'
default['tyk']['pump']['config']['uptime_pump_config']['mongo_url'] = node['tyk']['dashboard']['config']['mongo_url']
default['tyk']['pump']['config']['dont_purge_uptime_data'] = false
