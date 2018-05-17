default['symfony']['user'] = 'www-data'
default['symfony']['group'] = 'www-data'

default['symfony']['configset'] = {
  'default' => {
    'cookbook' => 'symfony-parameters',
    'template' => 'parameters.yml.erb',
    'parameters' => {},
  },
}

default['symfony']['config'] = {}
