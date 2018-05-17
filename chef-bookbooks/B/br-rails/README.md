# Rails Cookbook

Configures Rails applications

0. [Overview](#overview)
0. [Recipes](#recipes)
0. [Attributes](#attributes)
0. [Examples](#examples)
0. [Maintainers](#maintainers)

## Overview

This cookbook is designed to prepare a deployed Rails application to start. The three main phases are `configure`,
`install`, and `migrate`. The `configure` phase handles updating configuration files for the current environment, the
`install` phase will install gem dependencies, and the `migrate` phase will run database migrations.

Although this cookbook can download application code from a git repository using the `prepare` recipe, managing
deployments should be handled by a different cookbook. Application deployment has many concerns that go beyond
the scope of this project, such as managing multiple versions, rollbacks, restarts, in-place upgrades, etc.

**Note:** Built by Robots is committed to maintaining a simple, robust set of cookbooks that can be used to deploy Ruby
web applications in an enterprise setting. These open source projects will be humanely maintained and will not abrutly
lose support. Any future transitions of ownership or deprecation will be handled with clear communication and plenty of
advance notice.

## Recipes

### br-rails::default

Runs `configure`, `install`, and `migrate` recipes. The `prepare` recipe is not included by default since it is
recommened to create another cookbook to handle application deployment.

### br-rails::prepare

Prepares for configuration by installing package dependencies and syncing application code from a git repository.

### br-rails::configure

Configures a deployed Rails application. Typically this includes `production.rb`, `database.yml`, and `secrets.yml`, but
custom config files and templates are also supported.

### br-rails::install

Runs installation commands for a deployed Rails application like `bundle install`.

### br-rails::migrate

Runs migration commands for a deployed Rails application like `rake db:migrate`.

## Attributes

The following attributes reside under `rails`/`default` which contains the default attributes used for every every
application listed under `rails`/`applications`. To configure a new rails application, use the same set of keys, but
place them under `applications`. Example: `rails`/`applications`/`example`

| Key | Type | Description |
|-----|------|-------------|
| `install_path` | `String` | Directory containing Rails application folder |
| `dependencies` | `Array of Strings` | Package dependencies to install |
| `ruby`/`install_path` | `String` | Location where Ruby versions are installed |
| `ruby`/`version` | `String` | **Required:** Ruby version to use |
| `git`/`respository` | `String` | Git repository for application |
| `git`/`revision` | `String` | Git revision to sync |
| `owner` | `Type` | Owner of application files and folders |
| `group` | `Type` | Group of application files and folders |
| `mode` | `Type` | Mode of application files and folders |
| `environment` | `Type` | Application environment variables |
| `config` | `Hash` | Configuration fils |
| `install` | `Hash` | Installation commands |
| `migrate` | `Hash` | Migration commands |

[default values](attributes/default.rb)

## Examples

### Role

```json
{
  "name": "example",
  "chef_type": "role",
  "json_class": "Chef::Role",
  "description": "Example Role",
  "run_list": ["recipe[br-ruby::default]", "recipe[br-rails::prepare]", "recipe[br-rails::default]"],
  "default_attributes": {
    "ruby": {
      "versions": ["2.2.3"]
    },
    "rails": {
      "applications": {
        "example": {
          "ruby": {
            "version": "2.2.3"
          },
          "git": {
            "repository": "https://github.com/built-by-robots/rails-application.git"
          },
          "config": {
            "environment":{
              "values": {
                "cache_classes": "true",
                "eager_load": "true",
                "consider_all_requests_local": "false",
                "action_controller": {
                  "perform_caching": "true"
                },
                "serve_static_files": "ENV['RAILS_SERVE_STATIC_FILES'].present?",
                "assets": {
                  "js_compressor": ":uglifier",
                  "compile": "false",
                  "digest": "true"
                },
                "log_level": ":debug"
              }
            },
            "database": {
              "values": {
                "production": {
                  "adapter": "sqlite3",
                  "pool": "5",
                  "timeout": "5000",
                  "database": "db/development.sqlite3"
                }
              }
            },
            "secrets": {
              "values": {
                "production": {
                  "secret_key_base": "c8b92f99b11f01fc05a98245b9f2d32e8b6485a29447"
                }
              }
            }
          }
        }
      }
    }
  }
}

```

## Maintainers

* [Jim Pruetting](https://github.com/jpruetting)
