#
# Author:: pdeprey (<pdeprey@gmail.com>)
# Cookbook:: schannel
# Attribute:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# define eventlogging level when schannel are used
# details: https://support.microsoft.com/en-us/kb/260729
# 0	Do not log
# 1	Log error messages
# 2	Log warnings
# 4	Log informational and success events
default['schannel']['event_logging']['level'] = 1

# Set the secure protocols at client side
default['schannel']['protocols_client_side'] = true

# Protocols secure settings
default['schannel']['protocols']['mupuh']['enable'] = false # Disable Multi-Protocol Unified Hello
default['schannel']['protocols']['pct10']['enable'] = false # Disable PCT 1.0
default['schannel']['protocols']['ssl30']['enable'] = false # Disable SSL 3.0 (IE6/IE7 will fail)
default['schannel']['protocols']['ssl20']['enable'] = false # Disable SSL 2.0 (PCI Compliance)
default['schannel']['protocols']['tls10']['enable'] = true  # Enable SSL/TLS 1.0
default['schannel']['protocols']['tls11']['enable'] = true  # Enable SSL/TLS 1.1
default['schannel']['protocols']['tls12']['enable'] = true  # Enable SSL/TLS 1.2

# Ciphers secure settings
default['schannel']['ciphers']['aes_128128']['enable']  = true  # Enable AES 128/128
default['schannel']['ciphers']['aes_256256']['enable']  = true  # Enable AES 256/256
default['schannel']['ciphers']['3des_168168']['enable'] = true  # Enable 3DES 168/168
default['schannel']['ciphers']['rc2_40128']['enable']   = false # RC2 40/128 is an insecure cipher!
default['schannel']['ciphers']['rc2_56128']['enable']   = false # RC2 56/128 is an insecure cipher!
default['schannel']['ciphers']['rc2_128128']['enable']  = false # RC2 128/128 is an insecure cipher!
default['schannel']['ciphers']['rc4_40128']['enable']   = false # RC4 40/128 is an insecure cipher!
default['schannel']['ciphers']['rc4_56128']['enable']   = false # RC4 56/128 is an insecure cipher!
default['schannel']['ciphers']['rc4_64128']['enable']   = false # RC4 64/128 is an insecure cipher!
default['schannel']['ciphers']['rc4_128128']['enable']  = false # RC4 128/128 is an insecure cipher!
default['schannel']['ciphers']['des_5656']['enable']    = false # DES 56/56 is an insecure cipher!
default['schannel']['ciphers']['null']['enable']        = false # NULL is an insecure cipher!

# Hashes secure settings
default['schannel']['hashes']['md5']['enable']    = false # Disable MD5
default['schannel']['hashes']['sha']['enable']    = true  # Disable SHA-1
default['schannel']['hashes']['sha256']['enable'] = true  # Disable SHA-256
default['schannel']['hashes']['sha384']['enable'] = true  # Disable SHA-384
default['schannel']['hashes']['sha512']['enable'] = true  # Disable SHA-512

# KeyExchangeAlgorithms hashes secure settings
default['schannel']['keyexch']['diffiehellman']['enable'] = true # Enable Diffie-Hellman
default['schannel']['keyexch']['pkcs']['enable']          = true # Enable PKCS
default['schannel']['keyexch']['ecdh']['enable']          = true # Enable ECDH

# define the security cipher suite order
# 0 default (depend of windows version: https://msdn.microsoft.com/fr-fr/library/windows/desktop/aa374757(v=vs.85).aspx
# 1 secure (best practices defined in Nartac IIS Cryto: https://www.nartac.com/Products/IISCrypto)
default['schannel']['cipher_order']['secure'] = true

# This list is based on best practices defined in Nartac IIS Cryto:
# Details at: https://www.nartac.com/Products/IISCrypto
# You can use this default attribute to set your own cipher suite.
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
