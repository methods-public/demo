include_recipe 'chef-sugar'
include_recipe 'ignite-openfire::linux' if linux?
include_recipe 'ignite-openfire::windows' if windows?
