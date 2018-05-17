# shadowsocks_ng Cookbook

Install shadowsocks on your server.

This cookbook will create a system service "ssserver", while the configuration file is in `/etc/shadowsocks.json`.


## Requirements

### Platforms

- Ubuntu
- Debian
- CentOS

### Chef

- Chef 12.0 or later

### Cookbooks

- `poise-service` - for create a system service
- `poise-python` - for python packages management

## Attributes

### shadowsocks_ng::default

## Usage

### shadowsocks_ng::default

Just include `shadowsocks_ng` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[shadowsocks_ng]"
  ]
}
```

## Thanks

`jccode` for initial cookbook

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

- Authors:: merqlove
