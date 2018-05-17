# tmux-latest Cookbook

Use this cookbook to install the latest version of `tmux`.

### Platforms

This cookbook has been tested with the following platforms:

- Ubuntu 16.04
- Ubuntu 14.04
- Centos 7.2

### Attributes

- `node['tmux']['destination']` - Location where the `tmux` source code will be cloned from GitHub. By default, this is set to `/usr/local/tmux`.

- `node['tmux']['repo']` - The URL of the `tmux` GitHub repo. 

- `node['platform_specific_pkgs']` - Dependencies specific to the `rhel` and `debian` node families.

### Usage

Include the default recipe in your run list or use `include_recipe` in a recipe that is included in your run list. 

If you aren't managing your `git` installation with a more sophisticated recipe, this cookbook does offer a barebones package-based `git` installation. Make sure you include `tmux-latest::git` before `tmux-latest` itself if you need `git`.
