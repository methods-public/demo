default['annoyances']['omnios']['perform_pkg_refresh'] = true

default['annoyances']['debian']['perform_apt_get_update'] = true
default['annoyances']['debian']['services_to_disable'] = ['apparmor', 'whoopsie']
default['annoyances']['debian']['disable_byobu'] = true
default['annoyances']['debian']['packages_to_purge'] = ['popularity-contest', 'unity-lens-shopping', 'whoopsie']

default['annoyances']['rhel']['delete_existing_firewall_rules'] = true
default['annoyances']['rhel']['disable_selinux'] = true
default['annoyances']['rhel']['uninstall_httpd'] = true
default['annoyances']['rhel']['remove_root_dot_bash_logout'] = true
default['annoyances']['rhel']['services_to_disable'] = [
  'autofs',
  'avahi-daemon',
  'bluetooth',
  'cpuspeed',
  'cups',
  'gpm',
  'haldaemon',
  'messagebus'
]
