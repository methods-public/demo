#!/usr/bin/env bats

@test "HP SPP - hpssacli package is installed" {
  run rpm -q hpssacli
  [ "$status" -eq 0 ]
}

