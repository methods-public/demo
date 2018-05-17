# 2.1.1 Remove telnet-server
# 2.1.2 Remove telnet Clients
# 2.1.3 Remove rsh-server
# 2.1.4 Remove rsh
# 2.1.5 Remove NIS Client
# 2.1.6 Remove NIS Server
# 2.1.7 Remove tftp
# 2.1.8 Remove tftp-server
# 2.1.9 Remove talk
# 2.1.10 Remove talk-server
# 2.1.11 Remove xinetd
[
	'telnet-server',
	'telnet',
	'rsh-server',
	'rsh',
	'ypbind',
	'ypserv',
	'tftp',
	'tftp-server',
	'talk',
	'talk-server',
	'xinetd'
].each do |p|
	package p do
		action :remove
	end
end

# 2.1.12 Disable chargen-dgram
# 2.1.13 Disable chargen-stream
# 2.1.14 Disable daytime-dgram
# 2.1.15 Disable daytime-stream
# 2.1.16 Disable echo-dgram
# 2.1.17 Disable echo-stream
# 2.1.18 Disable tcpmux-server
[
	'chargen-dgram',
	'chargen-stream',
	'daytime-dgram',
	'daytime-stream',
	'echo-dgram',
	'echo-stream',
	'tcpmux-server'
].each do |s|
	service s do
		action [:stop, :disable]
	end
end
