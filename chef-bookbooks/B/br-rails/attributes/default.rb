#
# Cookbook Name:: br-rails
# Attributes:: default
#

default['rails'].tap do |rails|
  rails['applications'] = {}
end

default['rails']['default'].tap do |default|
  default['install_path'] = '/opt/applications'
  default['dependencies'] = []
  default['ruby'].tap do |ruby|
    ruby['install_path'] = '/opt/rubies'
  end
  default['git'].tap do |git|
    git['repository'] = nil
    git['revision'] = 'master'
  end
  default['owner'] = 'root'
  default['group'] = 'root'
  default['mode'] = '0755'
  default['environment'] = {
    'RAILS_ENV' => 'production'
  }
  default['config'] = {
    'environment' => {
      'template' =>  'environment.rb.erb',
      'directory' =>  'environments',
      'filename' =>  'production.rb'
    },
    'database' =>  {
      'filename' =>  'database.yml'
    },
    'secrets' =>  {
      'filename' =>  'secrets.yml'
    }
  }
  default['install']['gems'].tap do |bundler|
    bundler['command'] = 'bundle install'
    bundler['options'] = ['--deployment', '--without development test']
  end
  default['migrate']['database'].tap do |database|
    database['command'] = 'bundle exec rake db:migrate'
  end
end
