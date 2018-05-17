This cookbook was written primarily to automate several steps I often have to do in recipes:

+ Fetch some archive
+ Extract it somewhere
+ Symlink it elsewhere

All these steps are wrapped in a neat LWRP.

## Supported archive types

- gzip

## Usage

See the ```test.rb``` recipe for examples.

## LWRP options

+ ```archive_type```: gzip
+ ```download_to```: By default, to Chef's temp download directory. Can be changed to wherever.
+ ```extract```: defaults to ```true```
+ ```extract_to```: where to unpack the archive
+ ```strip```: defaults to ```true```. Remove the first-level directory from the archive.
+ ```symlink```: defaults to ```true```
+ ```symlink_to```: where to symlink it

## Contributing
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors
Authors: Jean-Francois Theroux <me@failshell.io>

License: Apache version 2
