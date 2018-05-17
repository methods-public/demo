# glances CHANGELOG

This file is used to list changes made in each version of the glances cookbook.

## 1.1.0
- Chef 13 compat
- Changed `python` dependency by `poise-python`

## 1.0.6
- return 0 at the end of do_stop/do_start init scripts functions

## 1.0.5
- Fix service restart: Do not exit init scripts from function

## 1.0.4
- Fix centos init script

## 1.0.3
- Restart glances service when configuration or init script changed

## 1.0.2
- Reload daemon for systemd service
- Set system user for glances service

## 1.0.1
- Fixed specs..

## 1.0.0
- `glances::service` recipe to setup glances service
- Supports `ubuntu`, `debian`, `centos` and `fedora` platforms
- `[glances][version]` attribute to install specific glances version
- `[glances][daemon]` attribute is replaces by `[glances][service]` for service config

## 0.3.0
- New attribute: `[glances][extra_pip_packages]`

## 0.2.0
- Glances configuration improved

## 0.1.0
- Initial release of glances
