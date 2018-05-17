# Artifactory Pro Cookbook
[![Build Status](http://img.shields.io/travis/opscode-cookbooks/jenkins.svg)][travis]

Installs and configures Artifactory pro.

## Requirements
- Chef 11 or higher
- **Ruby 1.9.3 or higher**

## Attributes
In order to keep the README managable and in sync with the attributes, this cookbook documents attributes inline. The usage instructions and default values for attributes can be found in the individual attribute files.

## Recipes
### default
Runs the installation and configuration recipes.

### installation
Installs and starts Artifactory if it is not already on the system.

### configuration
Configures the license key for Artifactory. To configure the license ensure you override `node['artifactory_pro']['configuration']['license']`

## Development
Please see the [Contributing](CONTRIBUTING.md) and [Issue Reporting](ISSUES.md) Guidelines.

## License & Authors
- Author: Sam Dunne [sam@sam-dunne.com](mailto:sam@sam-dunne.com)

```text
Copyright (C) 2015 Monkey Little

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

[travis]: http://travis-ci.org/monkeylittleinc/artifactory_pro
