#!/usr/bin/env bash

knife cookbook site share "shadowsocks_ng" -o ../

cd ../..

berks update shadowsocks_ng && berks upload shadowsocks_ng && berks apply dev

exit 0
