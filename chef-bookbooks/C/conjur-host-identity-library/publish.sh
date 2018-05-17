#!/bin/bash

conjur env run -c secrets.yml -- knife cookbook site share conjur-host-identity "Other" -o ../. -VV
