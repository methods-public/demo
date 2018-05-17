#!/usr/bin/env bash

knife cookbook site share "dante_ng" -o ../

cd ../..

berks update dante_ng && berks upload dante_ng && berks apply dev

exit 0
