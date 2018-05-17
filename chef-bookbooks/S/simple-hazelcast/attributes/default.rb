# frozen_string_literal: true
default['hazelcast']['user'] = 'hazelcast'
default['hazelcast']['group'] = 'hazelcast'
default['hazelcast']['home'] = '/opt/hazelcast'

default['hazelcast']['download_url'] = 'https://oss.sonatype.org/content/repositories/releases/com/hazelcast/hazelcast-all/3.4.2/hazelcast-all-3.4.2.jar'
default['hazelcast']['checksum'] = 'd80efb8c56373bd175f8a45f300ba3a33d007be2413ccc62a848ade54af04a17'

default['hazelcast']['java_home'] = nil
default['hazelcast']['java_opts'] = {}
default['hazelcast']['class_path'] = {}
