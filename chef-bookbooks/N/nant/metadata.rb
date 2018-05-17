name 'nant'
maintainer 'Fabrício Corrêa Duarte'
maintainer_email 'fabricio.c.duarte@outlook.com'
license 'MIT'
description 'NAnt is a free general purpose build tool similar to Apache Ant.'
long_description 'NAnt is a free open source general purpose build tool. It is built using .NET and it is very similar to, if not based on, Apache Ant.'
version '0.1.0'

chef_version '>= 12.1' if respond_to?(:chef_version)
depends 'windows'

supports 'windows'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/fabriciocduarte/cookbook-nant/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/fabriciocduarte/cookbook-nant'
