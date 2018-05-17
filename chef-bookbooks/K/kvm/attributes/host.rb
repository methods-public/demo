# packages to install as kvm host
case node['platform_family']
when 'debian'
  default['kvm']['host']['packages'] = %w(qemu-kvm libvirt-bin)
when 'rhel'
  default['kvm']['host']['packages'] = %w(qemu-kvm libvirt)
else
  fail 'unsupported platform'
end
