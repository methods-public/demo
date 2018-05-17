# Yum Repositories

Cookbook that wraps the [yum_repository resource](https://docs.chef.io/resource_yum_repository.html) allowing one to define repositories in attributes.

---

## Usage

### yum_repositories::default

Just include `yum_repositories` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[yum_repositories]"
  ]
}
```

Then move on to filling out some attributes.

## Attributes

### Ignore Failures

This set the ignore_failures default value for each repo you define.

Default Value: 

- `false`

Ruby usage:

```ruby
node['yum_repositories']['ignore_failures'] = true
```

JSON usage:

```json
{
  "yum_repositories": {
    "ignore_failures": true
  }
}
```

### Repositories

The set of repositories that you intend to manage.


Ruby usage:

```ruby
node['yum_repositories']['repositories'] = [
  "elastic-5.x" => [
    "baseurl" => "https://artifacts.elastic.co/packages/5.x/yum",
    "gpgcheck" => true,
    "gpgkey" => "https://artifacts.elastic.co/GPG-KEY-elasticsearch",
    "enabled" => true,
    "action" => "create"
  ],
  "influxdb" => [
    "name" => "InfluxDB",
    "ignore_failures" => false, # Overriding the global settings set earlier
    "baseurl" => "https://repos.influxdata.com/rhel/\\$releasever/\\$basearch/stable",
    "gpgcheck" => true,
    "gpgkey" => "https://repos.influxdata.com/influxdb.key",
    "enabled" => true,
    "action" => "create"
  ]
]
```

JSON usage:

```json
{
  "yum_repositories": {
    "repositories": {
      "elastic-5.x": {
        "baseurl": "https://artifacts.elastic.co/packages/5.x/yum",
        "gpgcheck": true,
        "gpgkey": "https://artifacts.elastic.co/GPG-KEY-elasticsearch",
        "enabled": true,
        "action": "create"
      },
      "influxdb": {
        "name": "InfluxDB",
        "ignore_failures": false,
        "baseurl": "https://repos.influxdata.com/rhel/\\$releasever/\\$basearch/stable",
        "gpgcheck": true,
        "gpgkey": "https://repos.influxdata.com/influxdb.key",
        "enabled": true,
        "action": "create"
      }
    }
  }
}
```

Each repository declaration you define wraps around the `yum_repository` resource built into Chef. More information that resource can be found [here](https://docs.chef.io/resource_yum_repository.html).