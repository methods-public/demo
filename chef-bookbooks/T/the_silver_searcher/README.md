# the\_silver\_searcher cookbook

Builds [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
from source.

## Requirements

This cookbook supports Debian and Red Hat platform families. It is
tested on the two most recent major versions of CentOS, the most recent stable
version of Debian, the most recent version of Fedora supporting yum, the current
and previous LTS versions of Ubuntu, and the most recent version of Ubuntu.

## Usage

Include `recipe[the_silver_searcher]` in a run list.

## Attributes

-   `[:the_silver_searcher][:version]` = version number to install

-   `[:the_silver_searcher][:checksum]` = checksum of tar.gz source for this
                                          version

-   `[:the_silver_searcher][:url]` = url of tar.gz source

-   `[:the_silver_searcher][:build_opt]` = options to pass to build.sh,
                                           e.g. to install to a different
                                           prefix, use
                                           '--prefix=/opt/the\_silver\_searcher'

## Recipes

-   default - installs The Silver Searcher to `/usr/local/bin/ag`

## Author

Author:: Mark Cornick (<mailto:mark@markcornick.com>)

## Contributors

Thanks to:

-   @muratayusuke (Yusuke Murata)
-   @byplayer
