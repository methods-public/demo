#!/bin/bash

tracking=$(chronyc tracking)
activity=$(chronyc activity)

last_offset=\
$(echo "${tracking}" | grep "Last offset" | cut -d ' ' -f8 | tr -d '+')
sources_online=\
$(echo "${activity}" | grep "sources online" | cut -d ' '  -f1)
sources_offline=\
$(echo "${activity}" | grep "sources offline" | cut -d ' '  -f1)
sources_burst_online=\
$(echo "${activity}" | grep "return to online" | cut -d ' '  -f1)
sources_burst_offline=\
$(echo "${activity}" | grep "return to offline" | cut -d ' '  -f1)

cat <<EOF
# TYPE node_chronyd_offset_seconds gauge
node_chronyd_offset_seconds ${last_offset}
# TYPE node_chronyd_sources_total gauge
node_chronyd_sources_total{status="online"} ${sources_online}
node_chronyd_sources_total{status="offline"} ${sources_offline}
node_chronyd_sources_total{status="burst_online"} ${sources_burst_online}
node_chronyd_sources_total{status="burst_offline"} ${sources_burst_offline}
EOF
