default['filesystem']['format'] = Mash.new
default['filesystem']['mount'] = Mash.new
default['filesystem']['config'] = Mash.new
default['filesystem']['include_recipe'] = Array.new
default['filesystem']['supported'] = %w(ext3 ext4)
default['filesystem']['packages']['ext2'] = value_for_platform(
  %w(ubuntu debian exherbo archlinux centos redhat suse fedora) => {
    'default' => ['e2fsprogs']
  }
)
default['filesystem']['packages']['ext3'] = node['filesystem']['packages']['ext2']
default['filesystem']['packages']['ext4'] = node['filesystem']['packages']['ext2']
default['filesystem']['packages']['btrfs'] = value_for_platform(
  %w(ubuntu debian exherbo archlinux centos redhat suse fedora) => {
    'default' => ['btrfs-tools']
  }
)
default['filesystem']['packages']['xfs'] = value_for_platform(
  %w(ubuntu debian exherbo archlinux centos redhat suse fedora) => {
    'default' => ['xfsprogs']
  }
)
default['filesystem']['packages']['fat'] = value_for_platform(
  %w(ubuntu debian exherbo archlinux centos redhat suse fedora) => {
    'default' => ['dosfstools']
  }
)
default['filesystem']['packages']['vfat'] = node['filesystem']['packages']['fat']
default['filesystem']['packages']['dos'] = node['filesystem']['packages']['fat']
default['filesystem']['packages']['ntfs'] = value_for_platform(
  %w(ubuntu debian exherbo archlinux centos redhat suse fedora) => {
    'default' => ['ntfsprogs', 'ntfs-3g']
  }
)
