# sbp_messageanalyzer CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## 0.2.0 (2017-04-22)

### Fixed

- Replaced `ms_dotnet45` with `ms_dotnet` as the former is deprecated

### Added

- Added Chef client minimum version 12.6 requirement
- Added basic ChefSpec "it should converge" test
- Added basic InSpec smoke tests to ensure application is installed successfully
- Added knife-cookbook-doc to auto generate README

### Changed

- Updated attribute and recipe files to include year/company in license header
- Updated `Gemfile` to only include what is not in ChefDK, [knife-cookbook-doc](https://github.com/realityforge/knife-cookbook-doc) and [stove](https://github.com/sethvargo/stove)

### Removed

- Removed support for 32 bit installs (attribute file only contains 64 bit install details now)
- Removed `windows` cookbook as it's no longer necessary

## 0.1.3 (2016-07-18)

### Fixed

- Fixed Chef 12 warnings ([#2](https://github.com/schubergphilis/sbp_messageanalyzer/issues/2))

## 0.1.2 (2015-02-26)

### Added

- Added `ms_dotnet45` dependency to satisfy requirements on Windows 2008 R2 ([#1](https://github.com/schubergphilis/sbp_messageanalyzer/issues/1))

## 0.1.1

### Fixed

- Wrong checksum in attributes file.
- Package name incorrect.

## 0.1.0

- Initial release of sbp_messageanalyzer
