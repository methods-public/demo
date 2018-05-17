# lamp_stack Cookbook

TODO: Enter the cookbook description here.

This cookbook will install httpd/apache , then install mysql server and load PHP modules along with PHPMYADMIN.

password setup :

The default password for root is "abcd1234" .
you can change it by running /usr/bin/mysql_secure_installation .

Load apache page :

Run http://your_serverIPaddress:port to check.
A custom html page will be loaded by deafult.

phpMyAdmin page :

Run http://your_serverIPaddress/phpMyAdmin .
This will open up the admin page.
default user : root
default password : abcd1234

Login to mysql from cli :

#mysql -u root -p

e.g.
This cookbook makes your favorite breakfast sandwich.

## Requirements

TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
### Platforms

- centos , redhat . Will extend support to ( suse , ubuntu ) in upcoming versions .

### Chef

- Chef 11.0 or later

### Cookbooks

- `toaster` - lamp_stack needs toaster to brown your bagel.

## Attributes

TODO: List your cookbook attributes here.

e.g.
### lamp_stack::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['lamp_stack']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### lamp_stack::default

TODO: Write usage instructions for each cookbook.

e.g.
Just include `lamp_stack` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[lamp_stack]"
  ]
}
```

## Contributing

TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: TODO: List authors

