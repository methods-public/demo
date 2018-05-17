module Ipv6ModuleDisabledDetector
	def self.checkModuleIsDisabled()
		linux_script = 'cat /sys/module/ipv6/parameters/disable'
		command = Mixlib::ShellOut.new(linux_script)
		command.run_command
		if command.stdout.to_i == 1
			return true
		else
			return false
		end
	end
end
