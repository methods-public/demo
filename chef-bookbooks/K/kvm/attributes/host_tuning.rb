# packages to install for kvm tuning
case node['platform_family']
when 'debian'
  default['kvm']['host']['tuning']['packages'] = %w(ebtables kvm-ipxe)
when 'rhel'
  default['kvm']['host']['tuning']['packages'] = %w(ebtables gpxe-roms-qemu)
else
  fail 'unsupported platform'
end

default['kvm']['host']['tuning']['ksm_enabled'] = true
