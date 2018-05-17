The omni-ruby uses a variety of testing components:

- Unit tests: [ChefSpec](https://github.com/chefspec/chefspec)
- Integration tests: [Test Kitchen](https://github.com/chef/test-kitchen)
- Chef Style lints: [Foodcritic](https://github.com/Foodcritic/foodcritic)
- Cook Style lints: [Cookstyle](https://github.com/chef/cookstyle)

Prerequisites
-------------
- ChefDK (https://downloads.chef.io/chefdk)
- Vagrant (https://vagrantup.com)

Development
-----------
1. Clone the git repository from GitHub:
  $ git clone git@github.com:spindance-ops/omni_ruby.git

2. Install the dependencies using bundler:
  $ bundle install

3. Create a branch for your changes:
  $ git checkout -b my_bug_fix

4. Make any changes
5. Write tests to support those changes. It is highly recommended you write both unit and integration tests.
6. Run the tests:
    - `bundle exec foodcritic .`
    - `bundle exec cookstyle --display-cop-names`
    - `bundle exec rspec spec/unit/recipes/*_spec.rb --format=documentation --color`
    - `bundle exec kitchen test`

7. Assuming the tests pass, open a Pull Request on GitHub
