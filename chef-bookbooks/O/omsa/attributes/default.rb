
default['omsa']['key'] = "http://linux.dell.com/repo/hardware/OMSA_7.3.1/RPM-GPG-KEY-dell\n    http://linux.dell.com/repo/hardware/OMSA_7.3.1/RPM-GPG-KEY-libsmbios"

default['omsa']['indep']['includepkgs'] = nil
default['omsa']['indep']['exclude'] = nil
default['omsa']['indep']['mirrorlist'] = "http://linux.dell.com/repo/hardware/OMSA_7.3.1/mirrors.cgi?osname=el#{node['platform_version'].to_i}&basearch=$basearch&native=1&dellsysidpluginver=$dellsysidpluginver"

default['omsa']['specific']['includepkgs'] = nil
default['omsa']['specific']['exclude'] = nil
default['omsa']['specific']['mirrorlist'] = "http://linux.dell.com/repo/hardware/OMSA_7.3.1/mirrors.cgi?osname=el#{node['platform_version'].to_i}&basearch=$basearch&native=1&sys_ven_id=$sys_ven_id&sys_dev_id=$sys_dev_id&dellsysidpluginver=$dellsysidpluginver"
