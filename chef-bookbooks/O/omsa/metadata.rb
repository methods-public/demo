name             'omsa'
maintainer       'David Meiners'
maintainer_email 'dmeiners@goldstar.com'
license          'Apache 2.0'
description      'Installs/Configures Dell OpenManage Server Administator'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
recipe            "omsa", "Configures Dell OMSA hardware indepenedent and hardware specific yum repos and installs yum-dellsysid plugin."
recipe            "omsa::firmware", "Installs a set of Dell IE rpms that will allow the use of 'bootstrap_firmware' to find all updatable devices on Dell PowerEdge servers."
recipe            "omsa::srvadmin", "Installs all base and optional Server Administrator Features including secure web interface at https://node[:ipaddress]:1311"

supports         'centos'
depends          'yum'

attribute "omsa/key",
  :display_name => "omsa repo gpgkey",
  :description => "URL(S) for gpgkey(s) for repo. Defaults to Dell keys",
  :required => "required"

attribute "omsa/indep/exclude",
  :display_name => "yum.repos.d/dell-omsa-indep.repo exclude",
  :description => "List of packages to exclude from updates or installs. This should be an array.  Shell globs using wildcards (eg. * and ?) are allowed.",
  :required => "optional"

attribute "omsa/indep/installonlypkgs",
  :display_name => "yum.repos.d/dell-omsa-indep.repo installonlypkgs",
  :description => "List of packages that should only ever be installed, never updated. Kernels in particular fall into this category.",
  :required => "optional"

attribute "omsa/indep/mirrorlist",
  :display_name => "yum.repos.d/dell-omsa-indep.repo mirrorlist",
  :description => "Set the mirrorlist to use in Dell hardware independent yum repo",
  :required => "required"

attribute "omsa/specific/exclude",
  :display_name => "yum.repos.d/dell-omsa-specific.repo exclude",
  :description => "List of packages to exclude from updates or installs. This should be an array.  Shell globs using wildcards (eg. * and ?) are allowed.",
  :required => "optional"

attribute "omsa/specific/installonlypkgs",
  :display_name => "yum.repos.d/dell-omsa-specific.repo installonlypkgs",
  :description => "List of packages that should only ever be installed, never updated. Kernels in particular fall into this category.",
  :required => "optional"

attribute "omsa/specific/mirrorlist",
  :display_name => "yum.repos.d/dell-omsa-specific.repo mirrorlist",
  :description => "Set the mirrorlist to use in Dell hardware specific yum repo",
  :required => "required"
