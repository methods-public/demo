# pathogen Cookbook

Use the custom resources provided by this cookbook to install [pathogen](https://github.com/tpope/vim-pathogen), a plugin manager for vim, as well as any plugins that you specify.

### Prerequisites

This cookbook expects `vim` and `git` to be available but does *not* provide resources or recipes for installing them.

### Attributes

N/A

### Resources

#### pathogen_base
The `pathogen_base` resource manages the basic installation of `pathogen`.

##### Properties
- `users` - A list of users for whom `pathogen` should be installed. Required.

##### Example
```ruby
pathogen_base 'install pathogen!' do 
  users ['root', 'vagrant']
end
```

#### pathogen_plugin
Installs plugins that can be found on GitHub. The "name property" of the resource is the name of the plugin. 

##### Properties
- `github_org` - The name of the GitHub organization or user that houses the repo.
- `users` - A list of users for whom `pathogen` should be installed. Required.

##### Example
```ruby
pathogen_plugin 'ctrlp.vim' do
  github_org 'ctrlpvim'
  users ['root', 'vagrant']
end
```

### Usage

1. Add `depends 'pathogen'` to your `metadata.rb`.

2. Go buck wild with the above two resources in your recipe of choice.

## Contributing

Please open an issue if you find a bug. Pull requests are also welcome. When submitting pull requests, please try to abide by the following guidelines:

1. Keep changes as small as possible
2. Rebase and squash extraneous commits whenever possible
3. Use detailed commit messages
4. Don't modify version information
