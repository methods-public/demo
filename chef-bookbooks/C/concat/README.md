# concat-cookbook

**concat** is a cookbook inspired by the Puppet **concat** module to allow you to build text files out of smaller orderable fragments. Use cases include building firewall rules, fragmenting monolithic configuration files into smaller chunks, etc.

## Supported Platforms

This was tested on Linux and should work as expected there. No idea whether it will work elsewhere.

## Requirements

Chef 12.2.1 or higher

## Usage

1. Require the **concat** cookbook in your own cookbook's `metadata.rb`.
2. Use the **concat_fragment** resource type to build up the fragments for the target file. At present the fragments will only make use of template files, and not cookbook files.
3. After all fragment resources have been assembled, use a **concat** resource, ensuring that the **path** attribute of this resource exactly matches the path you supplied for each fragment.

## Example

From the test fixture cookbook, this will create two fragments and meld them into a single concatenated file which will appear at `/tmp/test_create1/test`:

```text
concat_fragment 'test1.erb' do
  target '/tmp/test_create1/test'
end

concat_fragment 'test2.erb' do
  target '/tmp/test_create1/test'
  variables(
    var1: 'hello'
  )
end

directory '/tmp/test_create1'

concat '/tmp/test_create1/test'
```

## Current features

- allows creation of file fragments and concatenation into final file
- deletion of individual fragments and fragment directories
- fragments from cookbook files as well as templates
- lots of tests courtesy of Test Kitchen

## Upcoming features

- additional features relentlessly cribbed from the Puppet **concat** module

## Acknowledgments

- Thanks to the Puppet concat module (https://github.com/puppetlabs/puppetlabs-concat) for giving me the idea to replicate this in Chef.
- Thanks to the Chef Nginx cookbook (https://github.com/miketheman/nginx) for giving me something to reference while I cargo culted my way through Berkshelf and Test Kitchen for the first time.

## License and Authors

- Author: Edmund Rhudy <erhudy@gmail.com>

```text
Copyright 2015, Edmund Rhudy

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
