[![Build Status](https://travis-ci.org/sbp-cookbooks/sbp_messageanalyzer.svg?branch=master)](https://travis-ci.org/sbp-cookbooks/sbp_messageanalyzer) [![Cookbook Version](https://img.shields.io/cookbook/v/sbp_messageanalyzer.svg)](https://supermarket.chef.io/cookbooks/sbp_messageanalyzer)

# Description

Installs Microsoft Message Analyser.

# Requirements

## Platform:

* Windows

## Cookbooks:

* ms_dotnet (>= 3.1.1)

# Attributes

* `node['ms_dotnet']['v4']['version']` - Configures the version of .Net Framework to install. Defaults to `4.5`.
* `node['sbp_messageanalyzer']['url']` - Download URL for Message Analyzer. Defaults to `http://download.microsoft.com/download/2/8/3/283DE38A-5164-49DB-9883-9D1CC432174D/MessageAnalyzer64.msi`.
* `node['sbp_messageanalyzer']['checksum']` - SHA256 checksum of install file. Defaults to `9bc60aa8f823b9dd27943a78f64fd74b676b13d45eb546801bc487f565b7c1ea`.

# Recipes

* [sbp_messageanalyzer::default](#sbp_messageanalyzerdefault) - Recipe to install Microsoft Message Analyzer.

## sbp_messageanalyzer::default

Recipe to install Microsoft Message Analyzer.

# License and Maintainer

Maintainer: Schuberg Philis (<cookbooks@schubergphilis.com>)

Source: https://github.com/sbp-cookbooks/sbp_messageanalyzer<br>
Issues: https://github.com/sbp-cookbooks/sbp_messageanalyzer/issues

License: Apache 2.0

# Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request
