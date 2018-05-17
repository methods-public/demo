# azurecli Cookbook

TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwich.

## Requirements

TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
### Platforms

- SandwichOS

### Chef

- Chef 12.0 or later

### Cookbooks

- `toaster` - azurecli needs toaster to brown your bagel.

## Attributes

define version will use azure cli 1.0 or azure cli 2.0 preview

```bash
default['azurecli]['azure']['virtualenv'] = nil
default['azurecli']['azure']['version'] = nil
default['azurecli']['azure']['cli_version'] = nil
default['azurecli']['azure']['python']['version'] = '2'
default['azurecli']['azure']['python']['provider'] = :system
```

## Usage

### azurecli::default

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[azurecli]"
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

Authors: Alex Tu

