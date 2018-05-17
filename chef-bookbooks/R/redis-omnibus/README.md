# Redis Omnibus

[![Build Status](https://travis-ci.org/usemarkup/chef-redis.svg?branch=master)](https://travis-ci.org/usemarkup/chef-redis)

Installs redis 3.2.x for CentOS and removes the default
package startups and configuration.

*Note*: This cookbook does not make use of redis sentinel

## Usage

An example setup with 3x redis daemons, the standard redis-server, redis-sessions and redis-cache

```json
"redis-omnibus": {
  "servers": {
    "redis": {
      "port": 6379,
      "maxmemory": "512m"
    },
    "sessions": {
      "port": 5000,
      "maxmemory": "256mb"
    },
    "cache": {
      "port": 5001,
      "maxmemory": "1024mb",
      "maxmemorypolicy": "allkeys-lru"
    }
  }
}

```

```json
  "run_list": [
    "recipe[redis-omnibus]"
  ]
```

## Requirements

It assumes you have the yum-ius package (this cookbook does not provide it)

You could use https://github.com/chef-cookbooks/yum-ius

## Support

- CentOS 6.x
- CentOS 7.x

### Chef Support (tested)

- Chef 12.7+
- Chef 13.x
