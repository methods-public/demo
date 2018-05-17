default[:jackal][:directories][:configuration] = '/etc/jackal'
default[:jackal][:install][:gems] = ['jackal']
default[:jackal][:install][:packages] = []
default[:jackal][:user][:name] = 'jackal'
default[:jackal][:user][:home] = '/home/jackal'
default[:jackal][:apps] = Mash.new

default[:jackal][:exec_dir] = node[:languages][:ruby][:bin_dir]
default[:jackal][:exec_name] = 'jackal'
default[:jackal][:enabled] = Mash.new
