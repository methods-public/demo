# Testing

Testing is carried out via the following tools (also via CircleCI):

- `chef exec cookstyle`
- `chef exec foodcritic . -X spec -f any`
- `chef exec rspec -P spec/**/*_spec.rb --tty --color`

Testing via the following:

- `kitchen test`

is carried out locally.
