# Jackal

Run your jackals

## Usage

Provides simple LWRP for setting up jackal instances

```ruby

jackal 'stuff-doer' do
  configuration Mash.new(:jackal => 'configuration_hash')
  overrides [
    {:override_config_file => 'first one'},
    {:override_config_file => 'second one'}
  ]
  gem_packages ['nokogiri']
  system_packages ['libxslt-dev']
end
```

This will generate the required configuration, install required
gems and packages, configure the service (via runit) and start
it. Yay!

## Infos

* Repository: https://github.com/carnivore-rb/chef-jackal
* Jackal: https://github.com/carnivore-rb/jackal
