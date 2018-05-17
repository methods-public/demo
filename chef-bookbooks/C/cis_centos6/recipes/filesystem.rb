# 1.1.2 Set nodev option for /tmp Partition
# 1.1.3 Set nosuid option for /tmp Partition
# 1.1.4 Set noexec option for /tmp Partition
tmp_device = MountedDeviceFinder.find_device('/tmp')

mount '/tmp' do
	device tmp_device[:device]
	device_type tmp_device[:device_type]
	dump 1
	options node['cis_centos6']['filesystem']['tmp']['options']
	action [:enable, :mount]
end

# 1.1.6 Bind Mount the /var/tmp directory to /tmp
mount '/var/tmp' do
	device '/tmp'
	fstype 'none'
	options 'bind'
	pass 0
	action [:enable, :mount]
end

# 1.1.10 Add nodev Option to /home
home_device = MountedDeviceFinder.find_device('/home')

mount '/home' do
	device home_device[:device]
	device_type home_device[:device_type]
	dump 1
	options 'defaults,nodev'
	action [:enable, :mount]
end

# 1.1.14 Add nodev Option to /dev/shm Partition
# 1.1.15 Add nosuid Option to /dev/shm Partition
# 1.1.16 Add noexec Option to /dev/shm Partition
dev_shm_device = MountedDeviceFinder.find_device('/dev/shm')

mount '/dev/shm' do
	device dev_shm_device[:device]
	device_type dev_shm_device[:device_type]
	fstype 'tmpfs'
	options 'defaults,nodev,nosuid,noexec'
	pass 0
	action [:enable, :mount]
end

# 1.1.17 Set Sticky Bit on All World-Writable Directories
execute 'Set Sticky Bit on All World-Writable Directories' do
	command 'df --local -P | awk {\'if (NR!=1) print $6\'} | xargs -I \'{}\' find \'{}\' -xdev -type d \\( -perm -0002 -a ! -perm -1000 \\) 2>/dev/null | xargs chmod a+t'
	only_if '[[ $(df --local -P | awk {\'if (NR!=1) print $6\'} | xargs -I \'{}\' find \'{}\' -xdev -type d \\( -perm -0002 -a ! -perm -1000 \\) 2>/dev/null) ]]'
end
