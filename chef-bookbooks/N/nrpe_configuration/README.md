# nrpe_configuration

Configures the NRPE client for Windows.

## Supports:

- Windows :white_check_mark:

## Usage

### nrpe_configuration::default

Just include `nrpe_configuration` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nrpe_configuration]"
  ]
}
```

## Attributes 

### Install Directory:

Tells this cookbook where to look for the NS Clients.

Default Value: 

- `C:/Program Files/NSClient++/`

Ruby usage:

```ruby
node['nrpe_configuration']['install_directory'] = "D:/NSClient++/"
```

JSON usage:

```json
{
  "nrpe_configuration": {
    "install_directory": "D:/NSClient++/"
  }
}
```
###### Note: forward slashes are used for Windows paths in Ruby.


### Notify Service:

Tells the `nscp` service to restart after the configuration has changed.

Default Value: 

- `false`

Ruby usage:

```ruby
node['nrpe_configuration']['notify_service'] = true
```

JSON usage:

```json
{
  "nrpe_configuration": {
    "notify_service": true
  }
}
```

### Settings:

Settings that will be put in the `nsclient.ini`.

Ruby usage:

```ruby
node['nrpe_configuration']['settings'] = [
    "[/settings/default]" => nil,
    "allowed hosts" => "192.168.1.10",
    "[/modules]" => nil,
    "CheckSystem" => 1
  ]
```

JSON usage:

```json
{
  "nrpe_configuration": {
    "settings": {
      "[/settings/default]": null,
      "allowed hosts": "192.168.1.10",
      "[/modules]": null,
      "CheckSystem": 1
    }
  }
}
```
