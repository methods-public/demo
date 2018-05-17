# moodle-cookbook

## Supported Platforms

CentOS

## Attributes


## Usage

```
moodle "/var/www/moodle" do
  server_name "moodle.example.com"
  create_db_and_user false
end
```

You are responsible for making sure the webroot ("/var/www/moodle" in this example)
is filled.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `/user/add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Oregon State University (<systems@osuosl.org>)
