# schannel Cookbook

This cookbook manage the windows security channels.

## Requirements

### Platforms

- Windows 2008+

### Chef

- Chef 12.6+

### Recipes

- `default`: The default recipe configure the security channel.
- `unset`: This recipe restore the default windows configuration.

### Usage

This cookbook provides a default recipe to manage security channels on windows servers:
- Protocols (SSL, TLS)
- Ciphers (rc2, rc4, AES, DES)
- Hashes (MD5, SHA)
- Key Exchange Algorithms (PCKS,ECDH, Diffie-Hellman)

Add the schannel::default recipe in your run list to set the security best practises configuration.
Use the schannel::unset to restore the default windows configuration.
Customize your security configuration using attributes.

## Attributes

Here the main attributes to manage windows schannel:

Attribute                                         | Default Value | Description
------------------------------------------------- | ------------- | ------------------------------------------------------
`default['schannel']['event_logging']['level']`   | 1             | The level of schannel logging in Windows Event Viewer.
`default['schannel']['cipher_order']['secure']`   | true          | Apply a secure list of ciphers.
`default['schannel']['protocols_client_side']`    | true          | Apply the protocol configuration at the client side.

Others available attributes are used to enable/disable a protocol, cipher, hash or exchange key algorithm:

Attribute                                                   | Default Value | Description
----------------------------------------------------------- | ------------- | -----------------------------------------------------
`default['schannel']['protocols']['mupuh']['enable']`       | false         | Enable/Disable protocol Multi-Protocol Unified Hello.
`default['schannel']['protocols']['pct10']['enable']`       | false         | Enable/Disable protocol PCT 1.0.
`default['schannel']['protocols']['ssl30']['enable']`       | false         | Enable/Disable protocol SSL 3.0.
`default['schannel']['protocols']['ssl20']['enable']`       | false         | Enable/Disable protocol SSL 2.0.
`default['schannel']['protocols']['tls10']['enable']`       | true          | Enable/Disable protocol SSL/TLS 1.0.
`default['schannel']['protocols']['tls11']['enable']`       | true          | Enable/Disable protocol SSL/TLS 1.1.
`default['schannel']['protocols']['tls12']['enable']`       | true          | Enable/Disable protocol SSL/TLS 1.2.
`default['schannel']['ciphers']['aes_128128']['enable']`    | true          | Enable/Disable cipher AES 128/128.
`default['schannel']['ciphers']['aes_256256']['enable']`    | true          | Enable/Disable cipher AES 256/256.
`default['schannel']['ciphers']['3des_168168']['enable']`   | true          | Enable/Disable cipher 3DES 168/168.
`default['schannel']['ciphers']['rc2_40128']['enable']`     | false         | Enable/Disable cipher RC2 40/128.
`default['schannel']['ciphers']['rc2_56128']['enable']`     | false         | Enable/Disable cipher RC2 56/128.
`default['schannel']['ciphers']['rc2_128128']['enable']`    | false         | Enable/Disable cipher RC2 128/128.
`default['schannel']['ciphers']['rc4_40128']['enable']`     | false         | Enable/Disable cipher RC4 40/128.
`default['schannel']['ciphers']['rc4_56128']['enable']`     | false         | Enable/Disable cipher RC4 56/128.
`default['schannel']['ciphers']['rc4_64128']['enable']`     | false         | Enable/Disable cipher RC4 64/128.
`default['schannel']['ciphers']['rc4_128128']['enable']`    | false         | Enable/Disable cipher RC4 128/128.
`default['schannel']['ciphers']['des_5656']['enable']`      | false         | Enable/Disable cipher DES 56/56.
`default['schannel']['ciphers']['null']['enable']`          | false         | Enable/Disable cipher NULL.
`default['schannel']['hashes']['md5']['enable']`            | false         | Enable/Disable hash MD5.
`default['schannel']['hashes']['sha']['enable']`            | true          | Enable/Disable hash SHA-1.
`default['schannel']['hashes']['sha256']['enable']`         | true          | Enable/Disable hash SHA-256.
`default['schannel']['hashes']['sha384']['enable']`         | true          | Enable/Disable hash SHA-384.
`default['schannel']['hashes']['sha512']['enable']`         | true          | Enable/Disable hash SHA-512.
`default['schannel']['keyexch']['diffiehellman']['enable']` | true          | Enable Diffie-Hellman.
`default['schannel']['keyexch']['pkcs']['enable']`          | true          | Enable PKCS.
`default['schannel']['keyexch']['ecdh']['enable']`          | true          | Enable ECDH.

You can also define your own list of ciphers via `default['schannel']['cipher_order']['list']` attribute:

```
default['schannel']['cipher_order']['list'] = %w(
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P521
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P384
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P521
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384
  TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P521
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P384
  TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P256
  TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384_P521
  TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384_P384
  TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256_P521
  TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256_P384
  TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256_P256
  TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384_P521
  TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384_P384
  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256_P521
  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256_P384
  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256_P256
  TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA_P521
  TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA_P384
  TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA_P256
  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA_P521
  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA_P384
  TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA_P256
  TLS_RSA_WITH_AES_256_GCM_SHA384
  TLS_RSA_WITH_AES_128_GCM_SHA256
  TLS_RSA_WITH_AES_256_CBC_SHA256
  TLS_RSA_WITH_AES_128_CBC_SHA256
  TLS_RSA_WITH_AES_256_CBC_SHA
  TLS_RSA_WITH_AES_128_CBC_SHA
  TLS_RSA_WITH_3DES_EDE_CBC_SHA
)
```

Please check `defaut.rb` attribute file for a global view of attributes.

## Run list

### schannel::default
Just include `schannel` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[schannel]"
  ]
}
```

## License and Authors

- Author: Pierre DEPREY (pdeprey@gmail.com)

```text
Copyright:: 2016-2017, pde159

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