# nant Cookbook
[![](https://img.shields.io/badge/cookbook-v0.1.0-blue.svg?style=flat)]()

NAnt is a free open source general purpose build tool. It is built using .NET and it is very similar if not based on Apache Ant.

## Requirements

### Platforms
- Windows 7

### Chef
- Chef 12.7+

### Cookbooks
- windows

## Attributes

### Required
* `node['nant']['home']`
* `node['nant']['version']`

## Usage

Add `nant::default` to your runlist.

## License & Authors

**Author:** Fabrício Corrêa Duarte ([fabricio.c.duarte@outlook.com](mailto:fabricio.c.duarte@outlook.com.com))

**Copyright:** 2017, Fabrício Correa Duarte.

```
# The MIT License (MIT)
#
# Copyright:: 2017, Fabrício Corrêa Duarte
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
```

## Contributing

1. Fork the repository
2. Create a named feature branch (i.e. whip-something-awesome)
3. Write your change
4. Write tests for your change
5. Push your branch
6. Submit a Pull Request