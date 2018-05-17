# Octokit cookbook

This cookbook provides Chef resources to communicate with Github using
[Octokit tookit](https://github.com/octokit/octokit.rb).

## Resources

Currently the only resource provided by this cookbook
is Github User SSH Key.

### github_user_key

Example usage:
```ruby
github_user_key 'key' do
  login 'login'
  password 'token'
  title 'title'
  key 'ssh-rsa ...'
  action :create_or_replace
end
```

Supported actions:
*	The `create` action uploads key to Github. It gives an error
if the key is already in use with different title.
*	The `create_or_replace` action upload key to Github. If the key
is already in use by specified user and the title is different, it
removes the key and uploads with the new title.
*	The `remove` action searches for the key in the keys
of specified user and, if found, removes it.

PRs for other resources are welcome!
