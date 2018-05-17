# Yum Mesosphere Cookbook
This cookbook can be used to install and manage the mesosphere provided Yum
repositories.

## Requirements
* Chef 11 or higher
* [yum cookbook](https://supermarket.chef.io/cookbooks/yum) version 3.0.0+

## Recipes
### Default
The default recipe will configure the various mesosphere repos

## Attributes
Please refer to https://supermarket.chef.io/cookbooks/yum for a complete
list of attributes. Each attribute described on that page, can be set for a
given repository by setting `node['yum'][repoid][attribute]`.

## Usage
Add `yum_mesosphere` into your node's run_list prior to trying to install
mesosphere packages


## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# Authors
* David Petzel (davidpetzel@gmail.com)
