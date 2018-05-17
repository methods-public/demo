#!/bin/bash -x

rm -f Berksfile.lock Gemfile.lock

bundle install --path vendor/bundle --binstubs vendor/bin

bundle exec foodcritic .

bundle exec rubocop

# Runs all RSpec based tests: rspec, chefspec, serverspec, etc
bundle exec rspec

export KITCHEN_LOCAL_YAML=.kitchen.ci.yml
bundle exec kitchen test
bundle exec kitchen destroy
