#<> Use GitLab packagecloud repo
default['gitlab_omnibus']['use_packagecloud'] = true

#<
# The name of the GitLab Omnibus package. Determined automatically when using packagecloud
# but can be customized if using an internal package repository.
#>
default['gitlab_omnibus']['package_name'] = 'gitlab-ce'

#<> GitLab edition to install. `community` or `enterprise`
default['gitlab_omnibus']['edition'] = 'community'

#<
# Specify GitLab version to install. By default use latest version available at install time. If GitLab
# is already installed and a higher version is specified the package will be upgraded.
#>
default['gitlab_omnibus']['version'] = nil

#<
# `:install` or `:upgrade`? Beware, `:upgrade` will install the newest version as soon
# as it becomes available.
#>
default['gitlab_omnibus']['action'] = :install

# GitLab Configuration

#<> URL where GitLab will be accessible
default['gitlab_omnibus']['external_url'] = "https://#{node['fqdn']}"
#<> Git data directory. If value is nil, defaults to Omnibus value of `/var/opt/gitlab/git-data`
default['gitlab_omnibus']['git_data_dir'] = nil
#<> Configuration matching `gitlab_rails['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['gitlab_rails'] = {}
#<> Configuration matching `user['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['user'] = {}
#<> Configuration matching `unicorn['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['unicorn'] = {}
#<> Configuration matching `sidekiq['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['sidekiq'] = {}
#<> Configuration matching `gitlab_shell['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['gitlab_shell'] = {}
#<> Configuration matching `postgresql['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['postgresql'] = {}
#<> Configuration matching `redis['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['redis'] = {}
#<> Configuration matching `web_server['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['web_server'] = {}
#<> Configuration matching `nginx['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['nginx'] = {}
#<> Configuration matching `logging['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['logging'] = {}
#<> Configuration matching `logrotate['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['logrotate'] = {}
#<> Configuration matching `omnibus_gitconfig['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['omnibus_gitconfig'] = {}
#<> Configuration matching `high_availability['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['high_availability'] = {}

# GitLab CI

#<> Configuration matching `gitlab_ci['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['gitlab_ci'] = {}
#<> Configuration matching `ci_unicorn['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['ci_unicorn'] = {}
#<> Configuration matching `ci_sidekiq['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['ci_sidekiq'] = {}
#<> Configuration matching `ci_redis['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['ci_redis'] = {}
#<> Configuration matching `ci_nginx['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['ci_nginx'] = {}

# GitLab Container Registry

#<> URL where GitLab Container Registry will be accessible. Setting this value enables/configures GitLab Container Registry
default['gitlab_omnibus']['registry_external_url'] = nil
#<> Configuration matching `registry['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['registry'] = {}
#<> Configuration matching `registry_nginx['config_key']` from `gitlab.rb.template`
default['gitlab_omnibus']['registry_nginx'] = {}

# Backup

#<
# Configure a cron job to backup GitLab
# By default GitLab Omnibus keeps backups forever. Set
# node['gitlab_omnibus']['gitlab_rails']['backup_keep_time'] = '604800'
# (in seconds)
#>
default['gitlab_omnibus']['backup']['enable'] = true
#<> The command to create a backup. CRON=1 suppresses output unless there are errors
default['gitlab_omnibus']['backup']['command'] =
  'CRON=1 /opt/gitlab/bin/gitlab-rake gitlab:backup:create'
#<> The user to run the backup command as
default['gitlab_omnibus']['backup']['user'] = 'root'
#<> The cron minute
default['gitlab_omnibus']['backup']['minute'] = '0'
#<> The cron hour
default['gitlab_omnibus']['backup']['hour'] = '3'
#<> The cron day of the week
default['gitlab_omnibus']['backup']['day'] = '*'
#<> The cron month
default['gitlab_omnibus']['backup']['month'] = '*'
#<> The cron day of the week
default['gitlab_omnibus']['backup']['weekday'] = '*'
