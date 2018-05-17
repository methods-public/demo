# https://github.com/elastic/beats/blob/master/auditbeat/auditbeat.reference.yml
# https://www.elastic.co/guide/en/beats/auditbeat/current/auditbeat-overview.html

# auditbeat configuration
default['auditbeat']['config']['auditbeat.config.modules']['path'] = '${path.config}/conf.d/*.yml'
# default['auditbeat']['config']['auditbeat.config.modules']['reload.period'] = '10s'
# default['auditbeat']['config']['auditbeat.config.modules']['reload.enabled'] = false
# default['auditbeat']['config']['auditbeat.max_start_delay'] = '10s'
default['auditbeat']['config']['auditbeat.modules'] = []

# default['auditbeat']['config']['name'] = ''
# default['auditbeat']['config']['tags'] = []
# default['auditbeat']['config']['fields'] = {}
# default['auditbeat']['config']['fields_under_root'] = false
# default['auditbeat']['config']['queue']['mem']['events'] = 4096
# default['auditbeat']['config']['queue']['mem']['flush.min_events'] = 0
# default['auditbeat']['config']['queue']['mem']['flush.min_events'] = 0
# default['auditbeat']['config']['queue']['mem']['flush.timeout'] = '0s'
# default['auditbeat']['config']['max_procs'] =

# default['auditbeat']['config']['path.home'] = '/usr/share/auditbeat'
# default['auditbeat']['config']['path.config'] = '/etc/auditbeat'
# default['auditbeat']['config']['path.data'] = '/var/lib/auditbeat'
# default['auditbeat']['config']['path.logs'] = '/var/log/auditbeat'

# default['auditbeat']['config']setup.dashboards.enabled'] =  false
# default['auditbeat']['config']setup.dashboards.url'] = ''
# default['auditbeat']['config']setup.kibana']['host'] = 'localhost:5601'

# default['auditbeat']['config']['processors'] = []

# default['auditbeat']['logging.level'] = 'debug'
# default['auditbeat']['logging.selectors'] = ['*']

default['auditbeat']['config']['output'] = {}
# Elasticsearch host attributes
# default['auditbeat']['config']['output']['elasticsearch']['enable'] = true

# Logstash Output config attributes
# default['auditbeat']['config']['output']['logstash']['enable'] = true

# Redis Output config attributes
# default['auditbeat']['config']['output']['redis']['enable'] = true

# Logging Output attributes
# default['auditbeat']['config']['logging']['to_files'] = true
# if node['platform'] == 'windows'
#  default['auditbeat']['config']['logging']['files']['path'] = '"#{node['auditbeat']['conf_dir']}/logs"'
# end
# default['auditbeat']['config']['logging']['files']['rotateeverybytes'] = 10485760
# default['auditbeat']['config']['logging']['level'] = 'info'

# default['auditbeat']['config']['output']['file']['path'] = '/tmp/auditbeat'
# default['auditbeat']['config']['output']['file']['filename'] = 'auditbeat'
# default['auditbeat']['config']['output']['file']['rotate_every_kb'] = 1_000
# default['auditbeat']['config']['output']['file']['number_of_files'] = 7
