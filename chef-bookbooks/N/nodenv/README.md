[![Chef cookbook](https://img.shields.io/cookbook/v/nodenv.svg)]()
[![Travis](https://img.shields.io/travis/afaundez/nodenv-cookbook.svg)]()
# Nodenv Cookbook

Chef resource for [nodenv](https://github.com/nodenv/nodenv) installs, configuration and management of node versions.

## Cookbook

```ruby
cookbook 'nodenv', '~> 1.0.0'
```

## Resources

You can choose whether a user or a system install (or both). Check [test recipes](/test/fixtures/cookbooks/test/recipes) for working examples.

### Install

#### User

```ruby
nodenv_user 'user'
```

|Property|Type|Default|Details|
|-|-|-|-|
|`:user`|String||must be and existing user, acts as name property|
|`:nodenv_root`|String|`:user`'s home|a directory that must be writable by `:user`|
|`:git_url`|String|https://github.com/nodenv/nodenv.git|a valid git url|
|`:git_revision`|String|master|choose a branch|

#### System-wide

```ruby
nodenv_system 'system'
```

|Property|Type|Default|Details|
|-|-|-|-|
|`:nodenv_root`|String|`/usr/local/nodenv`||
|`:git_url`|String|https://github.com/nodenv/nodenv.git|a valid git url|
|`:git_revision`|String|master|choose a branch|

### Commands

Commands without `user` property will assume system-wide installation.

#### Install

Install a node version for user/system nodenv.

```ruby
nodenv_install '8.2.1' do
  user 'user'
end

nodenv_install '9.5.0'
```

|Property|Type|Default|Details|
|-|-|-|-|
|`:version`|String||must be a valid [node version](https://nodejs.org/en/download/releases/), acts as name property|
|`:user`|String|`root`|must be an existing user|
#### Global

Set a global node version for user/system-wide nodenv.

```ruby
nodenv_global '8.2.1' do
  user 'user'
end

nodenv_global '9.5.0'
```

|Property|Type|Default|Details|
|-|-|-|-|
|`:version`|String||must be installed node versions, acts as name property|
|`:user`|String|`root`|must be an existing user|

## Testing

Check [TESTING.md](TESTING.md)

## Development

Check [kitchen converge docs](https://kitchen.ci/docs/getting-started/running-converge).

## Acknowledgements

Based in [ruby_rbenv](https://github.com/sous-chefs/ruby_rbenv).
