#
# Copyright (c) 2017-2018 Make.org
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# We need HashDiff to spot any difference between current and requested config
chef_gem 'hashdiff' do
  compile_time true
end
require 'hashdiff'

# Parse iptables -S output
def parse(output)
  output.lines.map(&:chomp).map do |rule|
    splitted = rule.split(' ')
    case splitted.first
    when '-N' then nil # not handled here
    when '-A', '-P' then splitted[2..-1].join(' ') # rm action/chain as we know
    else raise "#{cookbook_name}: invalid action #{action} in apply_diff"
    end
  end.compact
end

# Expand rules containing %{group_name} token into multiple rules, each
#   containing a member of the group
# If a group is empty, any rules referencing this group will be removed
def insert_groups(rules, groups)
  rules.map do |rule, priority|
    match_data = /%{([^}]*)}/.match(rule)
    if match_data.nil?
      { rule => priority }
    else
      group = match_data.captures.first
      members = groups[group] || []
      members.map { |m| { format(rule, group.to_sym => m) => priority } }
    end
  end.flatten.reduce(&:merge)
end

# Generate iptables command to match requested config
# - create chain if needed
# - flush the chain
# - set Policy if needed
# - add all Append command
def generate_cmds(protocol, table, chain, requested, to_create = false)
  cmds = requested.map do |rule|
    action = %w[DROP ACCEPT].include?(rule) ? '-P' : '-A'
    "#{protocol} -t #{table} #{action} #{chain} #{rule}"
  end
  cmds.unshift("#{protocol} -t #{table} -F #{chain}")
  cmds.unshift("#{protocol} -t #{table} -N #{chain}") if to_create
  cmds
end

# Get groups (name => list of members)
groups = node.run_state.dig(cookbook_name, 'groups') || {}

# rubocop:disable Metrics/BlockLength
node[cookbook_name]['services'].each do |protocol, active|
  # Ignore unactive protocol (typically ipv6)
  next unless active

  node[cookbook_name][protocol]['tables'].each_pair do |table, chains|
    cmd_exist = "#{protocol} -S -t #{table} | grep '^-N' | cut -d' ' -f2"
    fixed = %w[PREROUTING INPUT FORWARD OUTPUT POSTROUTING]
    existing_chains = shell_out!(cmd_exist).stdout.lines.map(&:chomp) + fixed

    raw_cmds = chains.map do |chain, rules|
      current_rules, to_create =
        if existing_chains.include?(chain)
          cmd = "#{protocol} -S #{chain} -t #{table}"
          [parse(shell_out!(cmd).stdout), false]
        else
          [[], true]
        end

      if rules.to_s == 'undefined'
        ["#{protocol} -t #{table} -N #{chain}"] if to_create
      else
        # Get rules enriched with groups, sort by priority, filter positive
        # priority and keep only the rules
        requested_rules =
          insert_groups(rules, groups)
          .sort_by(&:last)
          .keep_if { |_, v| v >= 0 }
          .map(&:first)

        diff = ::HashDiff.diff(current_rules, requested_rules)
        if ::HashDiff.diff(diff, [['-', '[0]', 'ACCEPT']]).empty? ||
           ::HashDiff.diff(diff, [['-', '[0]', 'DROP']]).empty?
          diff = []
        end

        unless diff.empty? # rewrite the chain if there is any diff
          generate_cmds(protocol, table, chain, requested_rules, to_create)
        end
      end
    end

    cmds = raw_cmds.flatten.compact.map.with_index.sort_by do |rule, index|
      # Put -P & -N command in front so we create chain before needing them
      # then -F to have a clean state and finally others
      #
      # Some tricks here:
      # - "sort_by" sorts on the result of the "case", which is a string,
      #   by alphabetical order
      # - so to put all "-P" before, the sort value begins by "a"
      # - then "b" for "-N", etc.
      # - because "sort_by" is not guarantee to be stable, we use the previous
      #   index and append it to the sort value
      # - because "index" is a numeric converted to a string, we have to format
      #   it with leading 0 so the alphabetical order keeps 11 after 2 (02).
      index = format('%09d', index)
      case rule.split(' ')[3]
      when '-P' then "a_#{index}"
      when '-N' then "b_#{index}"
      when '-F' then "c_#{index}"
      else "d_#{index}"
      end
    end.map(&:first)

    cmds.each do |cmd|
      execute cmd
    end
  end
end
# rubocop:enable Metrics/BlockLength
