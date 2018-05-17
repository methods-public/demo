#!/usr/bin/env bats

@test "hipchat is found in PATH" {
  run which hipchat
  [ "$status" -eq 0 ]
}

@test "hipchat symlink can be dereferenced" {
  run ls -L `which hipchat`
  [ "$status" -eq 0 ]
}
