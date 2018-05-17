module MountedDeviceFinder
	def self.find_device(mount_point)
		command = Mixlib::ShellOut.new('cat /etc/fstab | grep -E \'^\\S+\\s+' + mount_point + '\s\' | cut -d \' \' -f1')
		command.run_command
		output = command.stdout.strip

		if output.start_with?('UUID=')
			{ device_type: :uuid, device: output[5..-1] }
		elsif output.start_with?('LABEL=')
			{ device_type: :label, device: output[6..-1] }
		else
			{ device_type: :device, device: output }
		end
	end
end
