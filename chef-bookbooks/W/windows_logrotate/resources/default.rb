actions :enable
default_action :enable

attribute :name, kind_of: String, name_attribute: true
attribute :username, kind_of: String, default: 'Administrator'
attribute :password, kind_of: [String, NilClass], sensitive: true
attribute :conf, kind_of: String
attribute :verbose, kind_of: [TrueClass, FalseClass], default: false
attribute :force, kind_of: [TrueClass, FalseClass], default: false
attribute :run_immediately, kind_of: [TrueClass, FalseClass], default: false
attribute :run_level, kind_of: String, default: 'LeastPrivilege'

attribute :cookbook, kind_of: String, default: 'windows_logrotate'
attribute :conf_tmpl, kind_of: String, default: 'logrotate.conf.erb'
attribute :schtask_tmpl, kind_of: String, default: 'schtask.xml.erb'

attribute :confidential, kind_of: [TrueClass, FalseClass]
