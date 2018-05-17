Windows Schannel Cookbook
=========================

Description
-------------
A cookbook to configure the windows Secure Channel [(Schannel)](https://msdn.microsoft.com/en-us/library/windows/desktop/aa380123) security support provider (SSP).
This SSP contains a set of security protocols and ciphers suites commonly used for HTTPS communications.  Many of the microsoft provided services and 3rd party software make use of Schannel for their communication so by removing support for a given protocol, removes it for all components.

This can be a double-edge sword, restricting a protocol might be fine for one service and end up breaking another.

Always make sure you __test__ these settings __before__ deploying into __production__ as you could end up __shooting yourself in the foot__

Using this cookbook should help improve your security posture for the following microsoft services and help towards meeting regulatory compliance (PCI CIS FIPS) 

* Internet Information Services (IIS)
* Microsoft Remote Desktop (RDP) _when configured to use TLS_
* LDAPS (Active Directory)
* Global Catalog SSL (Active Directory)
* WinRM/HTTPS (Windows Remote Management)

TODO : Insert image of external scan before and after.

Support for managing the following
----------------
### Protocols
+ Transport Layer Security (TLS) - v1.0, v1.1, v1.2
+ Secure Socket Layer (SSL) - v2.0, v3.0
+ Private Communications Technology (PCT) - v1.0

### Cipher Suites
+ NULL, DES, RC2, RC4, 3DES, AES

### Hashes
+ MD5, SHA

### Key Exchanges
+ Diffie-Hellman (DH)

Requirements
------------
#### Platforms
* Windows Server 2008 (R1, R2)
* Windows Server 2012 (R1, R2)

Attributes
----------
* `node['windows_schannel']['allow_reboot']` = `false` 
_changes made to protocols won't take affect until after a restart, this doesn't apply to ciphers and hashes. The default is false change this to true to initiate a reboot after the run._

Other than the `allow_reboot` attribute all the others are controlled by either setting it to either `enable` or `disable`
_this is CaSe Sensitive_

#### Protocols
* `node['windows_schannel']['pct_v1.0']` = `disable`
* `node['windows_schannel']['ssl_v2.0']` = `disable`
* `node['windows_schannel']['ssl_v3.0']` = `disable`
* `node['windows_schannel']['tls_v1.0']` = `enable`
* `node['windows_schannel']['tls_v1.1']` = `enable`
* `node['windows_schannel']['tls_v1.2']` = `enable`

#### Ciphers
* `node['windows_schannel']['cipher_null']` = `disable`
* `node['windows_schannel']['cipher_des']` = `disable`
* `node['windows_schannel']['cipher_rc2']` = `disable`
* `node['windows_schannel']['cipher_rc4']` = `disable`
* `node['windows_schannel']['cipher_3des']` = `enable`
* `node['windows_schannel']['cipher_aes']` = `enable`

#### Hashes
* `node['windows_schannel']['hash_md5']` = `enable`
* `node['windows_schannel']['hash_sha']` = `enable`

#### Key Exchanges
* `node['windows_schannel']['keyEx_dh']` = `enable`

License & Authors
-----------------
- Author:: Gary Bright (<digitalgaz@hotmail.com>)

```text
Copyright 2017, Gary Bright

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