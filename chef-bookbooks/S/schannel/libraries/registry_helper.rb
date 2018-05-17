#
# Author:: pdeprey (<pdeprey@gmail.com>)
# Cookbook:: schannel
# Library:: registry_helper
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
# this library check the correct name of channel defined in windows registry.

def registry_name(name)
  case name
  # protocols
  when 'mupuh' then 'Multi-Protocol Unified Hello'
  when 'pct10' then 'PCT 1.0'
  when 'ssl30' then 'SSL 3.0'
  when 'ssl20' then 'SSL 2.0'
  when 'tls10' then 'TLS 1.0'
  when 'tls11' then 'TLS 1.1'
  when 'tls12' then 'TLS 1.2'
  # ciphers
  when 'aes_128128' then 'AES 128/128'
  when 'aes_256256' then 'AES 256/256'
  when '3des_168168' then 'Triple DES 168/168'
  when 'rc2_40128' then 'RC2 40/128'
  when 'rc2_56128' then 'RC2 56/128'
  when 'rc2_128128' then 'RC2 128/128'
  when 'rc4_40128' then 'RC4 40/128'
  when 'rc4_56128' then 'RC4 56/128'
  when 'rc4_64128' then 'RC4 64/128'
  when 'rc4_128128' then 'RC4 128/128'
  when 'des_5656' then 'DES 56/56'
  when 'null' then 'NULL'
  # hashes
  when 'md5' then 'MD5'
  when 'sha' then 'SHA'
  when 'sha256' then 'SHA256'
  when 'sha384' then 'SHA384'
  when 'sha512' then 'SHA512'
  # key exchange algorithms
  when 'diffiehellman' then 'Diffie-Hellman'
  when 'pkcs' then 'PKCS'
  when 'ecdh' then 'ECDH'
  end
end
