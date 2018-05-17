# CHANGELOG for apache2-windows

This file is used to list changes made in each version of apache2-windows.

## 1.0.0 (2017-02-28)

- Require Chef 12.6+
- Replaced windows_package with package, which works better and doesn't require the windows cookbook dependency
- Added testing in Travis CI
- Resolved all cookstyle warnings
- Converted the virtual_host LWRP to a custom resource with proper update notification 

## 0.2.0:

* First version of the rewritten cookbook.

## 0.1.1:

* Bumping for fun

## 0.1.0:

* Initial release of apache2-windows

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
