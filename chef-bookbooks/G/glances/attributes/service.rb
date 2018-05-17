# -*- coding: utf-8 -*-
#
# Cookbook Name:: glances
# Attributes:: service
#
# Copyright 2015, Sliim
#

default['glances']['service'] = {
  RUN: false,
  DAEMON: '/usr/local/bin/glances',
  DAEMON_ARGS: '-s',
}
