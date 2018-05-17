#
# Cookbook Name:: windows_schannel
# Recipe:: ciphers
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
default['windows_schannel']['allow_reboot'] = false
# For both rest of the attributes use either 'enable' or 'disable' _it is CaSe Sensitive_
# Protocols
default['windows_schannel']['pct_v1.0'] = 'disable'
default['windows_schannel']['ssl_v2.0'] = 'disable'
default['windows_schannel']['ssl_v3.0'] = 'disable'
default['windows_schannel']['tls_v1.0'] = 'enable'
default['windows_schannel']['tls_v1.1'] = 'enable'
default['windows_schannel']['tls_v1.2'] = 'enable'
# Ciphers
default['windows_schannel']['cipher_null'] = 'disable'
default['windows_schannel']['cipher_des'] = 'disable'
default['windows_schannel']['cipher_rc2'] = 'disable'
default['windows_schannel']['cipher_rc4'] = 'disable'
default['windows_schannel']['cipher_3des'] = 'enable'
default['windows_schannel']['cipher_aes'] = 'enable'
# Hashes
default['windows_schannel']['hash_md5'] = 'enable'
default['windows_schannel']['hash_sha'] = 'enable'
# Key Exchanges
default['windows_schannel']['keyEx_dh'] = 'enable'
