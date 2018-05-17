# Chef community cookbook attributes
default['nginx']['upstream_repository'] = "http://nginx.org/packages/mainline/centos/#{node['platform_version'].to_i}/$basearch/"
default['nginx']['conf_template'] = 'nginx.conf.erb'
default['nginx']['conf_cookbook'] = 'alfresco-webserver'

# Default Nginx parameters, inherited by Alfresco attributes
default['nginx']['port'] = node['webserver']['port']
default['nginx']['proxy_port'] = node['webserver']['lb_port']
default['nginx']['ssl_port'] = node['webserver']['port_ssl']
default['nginx']['public_hostname'] = node['webserver']['hostname']
default['nginx']['proxy_hostname'] = node['webserver']['lb_hostname']
default['nginx']['log_level'] = 'info'

# JSON logging
default['nginx']['json_logging_enabled'] = false
default['nginx']['json_log_format'] = "main '{ \"@timestamp\": \"$time_iso8601\", \"@fields\": { \"remote_addr\": \"$remote_addr\", \"remote_user\": \"$remote_user\", \"x_forwarded_for\": \"$http_x_forwarded_for\", \"proxy_protocol_addr\": \"$proxy_protocol_addr\", \"body_bytes_sent\": \"$body_bytes_sent\", \"request_time\": \"$request_time\", \"body_bytes_sent\":\"$body_bytes_sent\", \"bytes_sent\":\"$bytes_sent\", \"status\": \"$status\", \"request\": \"$request\", \"request_method\": \"$request_method\", \"http_cookie\": \"$http_cookie\", \"http_referrer\": \"$http_referer\", \"http_user_agent\": \"$http_user_agent\" } }'"

# Nginx configurations (used by nginx.cfg.erb)
nginx_user = case node['platform_family']
             when 'rhel'
               'nginx'
             when 'debian'
               'www-data'
             end

default['nginx']['general']['user'] = nginx_user
default['nginx']['general']['worker_processes'] = 2
default['nginx']['events']['worker_connections'] = 1024

default['nginx']['http']['include'] = 'mime.types'
default['nginx']['http']['default_type'] = 'application/octet-stream'
default['nginx']['http']['log_format'] = "main  '$remote_addr - $remote_user [$time_local] \"$request\" ' '$status $body_bytes_sent \"$http_referer\" ' '\"$http_user_agent\" \"$http_x_forwarded_for\" \"$gzip_ratio\"'"
default['nginx']['http']['client_body_buffer_size'] = '1000M'
default['nginx']['http']['client_max_body_size'] = '0'
default['nginx']['http']['proxy_read_timeout'] = '600s'
default['nginx']['http']['keepalive_timeout'] = '120'
default['nginx']['http']['ignore_invalid_headers'] = 'on'
default['nginx']['http']['keepalive_requests'] = '50'
# Allow all browsers to use keepalive connections
default['nginx']['http']['keepalive_disable'] = 'none'
# Disabled to stop range header DoS attacks",
default['nginx']['http']['max_ranges'] = 0
default['nginx']['http']['msie_padding'] = 'off'
default['nginx']['http']['output_buffers'] = '1 512'
# Reset timed out connections freeing ram",
default['nginx']['http']['reset_timedout_connection'] = 'on'
# on for decent direct disk I/O",
default['nginx']['http']['sendfile'] = 'on'
# version number in error page'
default['nginx']['http']['server_tokens'] = 'off'
# Nagle buffering algorithm, used for keepalive only
default['nginx']['http']['tcp_nodelay'] = 'on'
# Send headers in one piece, its better then sending them one by one
default['nginx']['http']['tcp_nopush'] = 'on'
default['nginx']['http']['resolver'] = '8.8.4.4 8.8.8.8 valid=300s'
default['nginx']['http']['resolver_timeout'] = '10s'
default['nginx']['http']['access_log'] = '/var/log/nginx/host.access.log main'
default['nginx']['http']['error_log'] = "/var/log/nginx/error.log #{node['nginx']['log_level']}"
default['nginx']['http']['port_in_redirect'] = 'off'
default['nginx']['http']['server_name_in_redirect'] = 'off'
default['nginx']['http']['error_pages'] = ['403 /errors/403.http', '404 /errors/404.http', '405 /errors/405.http', '500 /errors/500.http', '501 /errors/501.http', '502 /errors/502.http', '503 /errors/503.http', '504 /errors/504.http']
default['nginx']['http']['gzip'] = 'on'
default['nginx']['http']['gzip_http_version'] = '1.1'
default['nginx']['http']['gzip_vary'] = 'on'
default['nginx']['http']['gzip_comp_level'] = 6
default['nginx']['http']['gzip_proxied'] = 'any'
default['nginx']['http']['gzip_buffers'] = '6 8k'
default['nginx']['http']['gzip_disable'] = '"MSIE [1-6]\\.(?!.*SV1)"'
# Turn on gzip for all content types that should benefit from it.
default['nginx']['http']['gzip_types'] = 'text/plain text/css text/javascript application/x-javascript application/javascript application/ecmascript application/rss+xml application/atomsvc+xml application/atom+xml application/cmisquery+xml application/cmisallowableactions+xml application/cmisatom+xml application/cmistree+xml application/cmisacl+xml application/msword application/vnd.ms-excel application/vnd.ms-powerpoint application/json'

default['nginx']['server']['status']['listen'] = '2100'
default['nginx']['server']['status']['locations']['/nginx_status']['stub_status'] = 'on'
default['nginx']['server']['status']['locations']['/nginx_status']['access_log'] = 'off'
default['nginx']['server']['status']['locations']['/nginx_status']['allow'] = '127.0.0.1'
default['nginx']['server']['status']['locations']['/nginx_status']['deny'] = 'all'

default['nginx']['server']['proxy']['listen'] = node['nginx']['port']
default['nginx']['server']['proxy']['server_name'] = node['nginx']['proxy_hostname']

default['nginx']['server']['proxy']['locations']['^~ /var/www/html/errors/']['internal'] = ''
default['nginx']['server']['proxy']['locations']['^~ /var/www/html/errors/']['root'] = node['webserver']['error_pages']['error_folder']

default['nginx']['server']['proxy']['locations']['/']['proxy_next_upstream'] = 'error timeout invalid_header http_500 http_502 http_503 http_504'
default['nginx']['server']['proxy']['locations']['/']['proxy_redirect'] = 'off'
default['nginx']['server']['proxy']['locations']['/']['proxy_http_version'] = '1.1'
default['nginx']['server']['proxy']['locations']['/']['proxy_set_headers'] = [
  'Host $host',
  'X-Real-IP $remote_addr',
  'X-Forwarded-For $proxy_add_x_forwarded_for',
  'X-Forwarded-Proto $scheme',
]
default['nginx']['server']['proxy']['locations']['/']['proxy_pass'] = "#{node['webserver']['lb_protocol']}://#{node['nginx']['proxy_hostname']}:#{node['nginx']['proxy_port']}"
# Set files larger than 1M to stream rather than cache
default['nginx']['server']['proxy']['locations']['/']['proxy_max_temp_file_size'] = '1M'

# SSL configurations
default['nginx']['ssl_folder'] = node['webserver']['certs']['ssl_folder']
default['nginx']['ssl_filename'] = node['webserver']['certs']['filename']

default['nginx']['ssl_server_redirect']['listen'] = node['nginx']['port']
default['nginx']['ssl_server_redirect']['server_name'] = node['nginx']['public_hostname']
default['nginx']['ssl_server_redirect']['add_header'] = 'Strict-Transport-Security "max-age=31536000; includeSubdomains;"'
default['nginx']['ssl_server_redirect']['return'] = '301 https://$server_name$request_uri'

default['nginx']['ssl_server_proxy']['add_header'] = 'Strict-Transport-Security "max-age=31536000; includeSubdomains;"'
default['nginx']['ssl_server_proxy']['ssl'] = 'on'
default['nginx']['ssl_server_proxy']['ssl_certificate'] = "#{node['nginx']['ssl_folder']}/#{node['nginx']['ssl_filename']}.nginxcrt"
default['nginx']['ssl_server_proxy']['ssl_certificate_key'] = "#{node['nginx']['ssl_folder']}/#{node['nginx']['ssl_filename']}.key"
default['nginx']['ssl_server_proxy']['ssl_trusted_certificate'] = "#{node['nginx']['ssl_folder']}/#{node['nginx']['ssl_filename']}.chain"

# Enable ocsp stapling - http://en.wikipedia.org/wiki/OCSP_stapling
default['nginx']['ssl_server_proxy']['ssl_stapling'] = 'on'
default['nginx']['ssl_server_proxy']['ssl_stapling_verify'] = 'on'
default['nginx']['ssl_server_proxy']['ssl_protocols'] = 'TLSv1 TLSv1.1 TLSv1.2'

default['nginx']['ssl_server_proxy']['ssl_dhparam'] = "#{node['nginx']['ssl_folder']}/#{node['nginx']['ssl_filename']}.dhparam"

# Use Intermediate Cipher Compatibility
# https://wiki.mozilla.org/Security/Server_Side_TLS#Intermediate_compatibility_.28default.29
default['nginx']['ssl_server_proxy']['ssl_prefer_server_ciphers'] = 'on'
default['nginx']['ssl_server_proxy']['ssl_ciphers'] = 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA'

# SSL Cache configuration
default['nginx']['ssl_server_proxy']['ssl_session_cache'] = 'shared:SSL:25m'
default['nginx']['ssl_server_proxy']['ssl_session_timeout'] = '10m'
default['nginx']['ssl_server_proxy']['ssl_buffer_size'] = '1400'
default['nginx']['ssl_server_proxy']['ssl_session_tickets'] = 'off'
default['nginx']['service']['actions'] = [:enable, :start]
