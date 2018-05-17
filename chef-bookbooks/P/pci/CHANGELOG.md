# Changelog of the pci cookbook

This file is used to list changes made in each version of the pci cookbook.

## Version 0.3.5
- Allow zero as valid ID on linux

## Version 0.3.4
- Initialize the pci attribute namespace

## Version 0.3.3
- Convert PNP ID to uppercase

## Version 0.3.2
- ::PCI.devices return an empty Mash on non-supported platforms

## Version 0.3.1
- Correct method to retrieve PNP DeviceID on windows

## Version 0.3.0
- Fix inverted sdevice\_id & svendor\_id on Windows
- Add Chef setting to control wether to load pci attributes or not
- Improve library testing
- Add Appveyor CI

## Version 0.2.0
- Read Linux PCI data from PCI Configuration space

## Version 0.1.0
- Expose PCI attributes on Linux
- Expose PCI attributes on Windows

## Version 0.0.0
- Initial commit
