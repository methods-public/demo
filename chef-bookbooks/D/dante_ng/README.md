# dante_ng Cookbook

Install dante on your server.

This cookbook will create a system service "dante", while the configuration file is in `/etc/sockd.conf`.


## Requirements

### Platforms

- CentOS

### Chef

- Chef 12.0 or later

## Attributes

### dante_ng::default

## Usage

### dante_ng::default

Just include `dante_ng` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[dante_ng]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

- Authors:: merqlove
