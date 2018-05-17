default['elastic_beats_repo']['setup_repo'] = true
default['elastic_beats_repo']['version'] = '5.3.6'
default['elastic_beats_repo']['yum']['description'] = 'Elastic Beats Repository'
default['elastic_beats_repo']['yum']['gpgcheck'] = true
default['elastic_beats_repo']['yum']['enabled'] = true
default['elastic_beats_repo']['yum']['priority'] = %w[amazon].include?(node['platform_family']) ? '10' : nil
default['elastic_beats_repo']['yum']['metadata_expire'] = '3h'
default['elastic_beats_repo']['yum']['action'] = :create

default['elastic_beats_repo']['apt']['description'] = 'Elastic Beats Repository'
default['elastic_beats_repo']['apt']['components'] = %w[stable main]
default['elastic_beats_repo']['apt']['distribution'] = ''
default['elastic_beats_repo']['apt']['action'] = :add
