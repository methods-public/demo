# -*- coding: utf-8 -*-
#
# Cookbook Name:: glances
# Attributes:: default
#
# Copyright 2015, Sliim
#

default['glances']['extra_pip_packages'] = %w(pystache)
default['glances']['version'] = nil

default['glances']['config'] = {
  cpu: {
    user_careful: 50,
    user_warning: 70,
    user_critical: 90,
    iowait_careful: 50,
    iowait_warning: 70,
    iowait_critical: 90,
    system_careful: 50,
    system_warning: 70,
    system_critical: 90,
    steal_careful: 50,
    steal_warning: 70,
    steal_critical: 90,
  },
  percpu: {
    user_careful: 50,
    user_warning: 70,
    user_critical: 90,
    iowait_careful: 50,
    iowait_warning: 70,
    iowait_critical: 90,
    system_careful: 50,
    system_warning: 70,
    system_critical: 90,
  },
  load: {
    careful: 0.7,
    warning: 1.0,
    critical: 5.0,
  },
  mem: {
    careful: 50,
    warning: 70,
    critical: 90,
  },
  memswap: {
    careful: 50,
    warning: 70,
    critical: 90,
  },
  fs: {
    careful: 50,
    warning: 70,
    critical: 90,
  },
  sensors: {
    temperature_core_careful: 60,
    temperature_core_warning: 70,
    temperature_core_critical: 80,
    temperature_hdd_careful: 45,
    temperature_hdd_warning: 52,
    temperature_hdd_critical: 60,
    battery_careful: 80,
    battery_warning: 90,
    battery_critical: 95,
  },
  processlist: {
    cpu_careful: 50,
    cpu_warning: 70,
    cpu_critical: 90,
    mem_careful: 50,
    mem_warning: 70,
    mem_critical: 90,
  },
}
