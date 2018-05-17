default['git-extensions']['version'] = '2.49'
default['git-extensions']['url'] = "https://github.com/gitextensions/gitextensions/releases/download/v#{default['git-extensions']['version']}/GitExtensions-#{default['git-extensions']['version']}-SetupComplete.msi"
default['git-extensions']['package_name'] = "Git Extensions version #{default['git-extensions']['version']}"
default['git-extensions']['install_path'] = "#{ENV['ProgramFiles']}"
