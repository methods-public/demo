module PrivilegedCommands
	def self.getCommands()
		privileged_commands = Mixlib::ShellOut.new('find / -xdev \\( -perm -4000 -o -perm -2000 \\) -type f | awk \'{print "-a always,exit -F path=" $1 " -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged" }\'')
		privileged_commands.run_command
		return privileged_commands.stdout
	end
end
