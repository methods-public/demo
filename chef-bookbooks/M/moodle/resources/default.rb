actions :create

default_action :create

attribute :admin, :kind_of => [ String ], :default => nil
attribute :config_dir, :kind_of => [ String ], :name_attribute => true
attribute :create_db_and_user, :kind_of => [ TrueClass, FalseClass ], :default => true
attribute :dbhost, :kind_of => [ String ], :default => 'localhost'
attribute :dbname, :kind_of => [ String ], :default => 'moodle'
attribute :dbpass, :kind_of => [ String ], :default => 'moodle'
attribute :dbpersist, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :dbport, :kind_of => [ String, Integer ], :default => ''
attribute :dbprefix, :kind_of => [ String ], :default => "mdl_"
attribute :dbrootpass, :kind_of => [ String ], :default  => "moodle"
attribute :dbsocket, :kind_of => [ TrueClass, FalseClass ], :default => false
attribute :dbtype, :kind_of => [ String ], :default => "mysqli"
attribute :dbuser, :kind_of => [ String ], :default => "moodle"
attribute :fastcgi_pass, :kind_of => [ String ], :default => "moodle"
attribute :passwordsalt1, :kind_of => [ String ], :default => "salt1"
attribute :passwordsaltmain, :kind_of => [ String ], :default => "salt"
attribute :server_name, :kind_of => [ String ], :default => "localhost"
attribute :web_root, :kind_of => [ String ], :name_attribute => true
