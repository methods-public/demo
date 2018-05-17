# How to become a contributor and submit your own code

## Contributor License Agreements

We'd love to accept your sample apps and patches! Before we can take them, we
have to jump a couple of legal hurdles.

Please fill out either the individual or corporate Contributor License
Agreement (CLA).

  * If you are an individual writing original source code and you're sure you
    own the intellectual property, then you'll need to sign an [individual CLA]
    (https://developers.google.com/open-source/cla/individual).
  * If you work for a company that wants to allow you to contribute your work,
    then you'll need to sign a [corporate CLA]
    (https://developers.google.com/open-source/cla/corporate).

Follow either of the two links above to access the appropriate CLA and
instructions for how to sign and return it. Once we receive it, we'll
be able to accept your pull requests.

## Contributing A Patch

1. Submit an issue describing your proposed change to the repo in question.
1. The repo owner will respond to your issue promptly.
1. If your proposed change is accepted, and you haven't already done so, sign a
   Contributor License Agreement (see details above).
1. Fork the desired repo, develop and test your code changes.
1. Ensure that your code adheres to the existing style in the sample to which
   you are contributing.
1. Ensure that your code has an appropriate set of unit tests which all pass.
1. Submit a pull request.

## Style

We adhere as much as possible to the [ruby-style-guide][] and make the code
[rubocop][] compliant. Tests are setup to fail if there are style guide
violations.

## Testing

Please make sure all tests pass before sending a patch. This will help us to
approve your change faster.

As a matter of policy the master branch is always passing all tests, and changes
that break tests cannot be accepted. If that's your case reach out and we can
help you get it fixed.

### Running Tests

```
gem install bundler
bundle install
bundle exec rspec
bundle exec rubocop
```

## Auto generated files

Various of the files in this repository are automatically generated by
chef-codegen. Such files contain a prominent comment warning for its
auto generated origins. However some types, such as JSON or MD, do not allow
embedding comments without breaking the file or causing side effects.

### Changing auto generated files

Of course these files are not perfect there will inevitably be issues with them.
If you find an issue with them there are 2 options:

1. Send a patch to the affected files to us and we'll update the source used to
   generate the file, thus addressing the issue. Note that in this option your
   patch will not be accepted but will be used as a guide to fix the original
   file.

2. Change the file directly in the sources used by chef-codegen. By taking
   this approach your change will be attributed to you, as you'd be the author
   of the change. If you'd like to take credit for the change this is the
   recommended approach. This approach has the nice side effect to fix all other
   projects that have the same issue at once.

### File list

The list below contains all the files that were automatically generated by
chef-codegen:

  * .gitignore
  * .rubocop.yml
  * Berksfile
  * CHANGELOG.md
  * chefignore
  * CONTRIBUTING.md
  * Gemfile
  * lib/google/object_store.rb
  * libraries/__init__.rb
  * libraries/google/sql/network/base.rb
  * libraries/google/sql/network/delete.rb
  * libraries/google/sql/network/get.rb
  * libraries/google/sql/network/post.rb
  * libraries/google/sql/network/put.rb
  * libraries/google/sql/property/array.rb
  * libraries/google/sql/property/boolean.rb
  * libraries/google/sql/property/enum.rb
  * libraries/google/sql/property/instance_authorized_networks.rb
  * libraries/google/sql/property/instance_failover_replica.rb
  * libraries/google/sql/property/instance_ip_addresses.rb
  * libraries/google/sql/property/instance_ip_configuration.rb
  * libraries/google/sql/property/instance_mysql_replica_configuration.rb
  * libraries/google/sql/property/instance_name.rb
  * libraries/google/sql/property/instance_replica_configuration.rb
  * libraries/google/sql/property/instance_settings.rb
  * libraries/google/sql/property/integer.rb
  * libraries/google/sql/property/string.rb
  * libraries/google/sql/property/string_array.rb
  * libraries/google/sql/property/time.rb
  * LICENSE
  * metadata.rb
  * README.md
  * recipes/examples~database.rb
  * recipes/examples~delete_database.rb
  * recipes/examples~delete_instance.rb
  * recipes/examples~delete_user.rb
  * recipes/examples~flag.rb
  * recipes/examples~instance.rb
  * recipes/examples~instance~postgres.rb
  * recipes/examples~ssl_cert.rb
  * recipes/examples~tier.rb
  * recipes/examples~user.rb
  * recipes/README.md
  * recipes/tests~database.rb
  * recipes/tests~delete_database.rb
  * recipes/tests~delete_instance.rb
  * recipes/tests~delete_user.rb
  * recipes/tests~flag.rb
  * recipes/tests~instance.rb
  * recipes/tests~instance~postgres.rb
  * recipes/tests~ssl_cert.rb
  * recipes/tests~tier.rb
  * recipes/tests~user.rb
  * resources/database.rb
  * resources/flag.rb
  * resources/instance.rb
  * resources/ssl_cert.rb
  * resources/tier.rb
  * resources/user.rb
  * spec/bundle.rb
  * spec/cookbooks/google-gauth/metadata.rb
  * spec/data/network/gsql_database/success1~name.yaml
  * spec/data/network/gsql_database/success1~title.yaml
  * spec/data/network/gsql_database/success2~name.yaml
  * spec/data/network/gsql_database/success2~title.yaml
  * spec/data/network/gsql_database/success3~name.yaml
  * spec/data/network/gsql_database/success3~title.yaml
  * spec/data/network/gsql_flag/success1~name.yaml
  * spec/data/network/gsql_flag/success1~title.yaml
  * spec/data/network/gsql_flag/success2~name.yaml
  * spec/data/network/gsql_flag/success2~title.yaml
  * spec/data/network/gsql_flag/success3~name.yaml
  * spec/data/network/gsql_flag/success3~title.yaml
  * spec/data/network/gsql_instance/success1~name.yaml
  * spec/data/network/gsql_instance/success1~title.yaml
  * spec/data/network/gsql_instance/success2~name.yaml
  * spec/data/network/gsql_instance/success2~title.yaml
  * spec/data/network/gsql_instance/success3~name.yaml
  * spec/data/network/gsql_instance/success3~title.yaml
  * spec/data/network/gsql_ssl_cert/success1~name.yaml
  * spec/data/network/gsql_ssl_cert/success1~title.yaml
  * spec/data/network/gsql_ssl_cert/success2~name.yaml
  * spec/data/network/gsql_ssl_cert/success2~title.yaml
  * spec/data/network/gsql_ssl_cert/success3~name.yaml
  * spec/data/network/gsql_ssl_cert/success3~title.yaml
  * spec/data/network/gsql_tier/success1~name.yaml
  * spec/data/network/gsql_tier/success1~title.yaml
  * spec/data/network/gsql_tier/success2~name.yaml
  * spec/data/network/gsql_tier/success2~title.yaml
  * spec/data/network/gsql_tier/success3~name.yaml
  * spec/data/network/gsql_tier/success3~title.yaml
  * spec/data/network/gsql_user/success1~name.yaml
  * spec/data/network/gsql_user/success1~title.yaml
  * spec/data/network/gsql_user/success2~name.yaml
  * spec/data/network/gsql_user/success2~title.yaml
  * spec/data/network/gsql_user/success3~name.yaml
  * spec/data/network/gsql_user/success3~title.yaml
  * spec/database_spec.rb
  * spec/fake_auth.rb
  * spec/fake_cred.rb
  * spec/flag_spec.rb
  * spec/foodcritic_spec.rb
  * spec/instance_spec.rb
  * spec/network_blocker.rb
  * spec/network_blocker_spec.rb
  * spec/network_delete_spec.rb
  * spec/network_get_spec.rb
  * spec/network_post_spec.rb
  * spec/network_put_spec.rb
  * spec/spec_helper.rb
  * spec/ssl_cert_spec.rb
  * spec/test_constants.rb
  * spec/tier_spec.rb
  * spec/user_spec.rb

The list below contains all the files that were automatically sourced from a
central location:

  * Gemfile.lock
  * libraries/google/hash_utils.rb
  * libraries/google/string_utils.rb
  * LICENSE
  * spec/data/poor_recipe.rb
  * spec/hash_utils_spec.rb
  * spec/string_utils_spec.rb

[ruby-style-guide]: https://github.com/bbatsov/ruby-style-guide
[rubocop]: https://rubocop.readthedocs.io/en/latest/