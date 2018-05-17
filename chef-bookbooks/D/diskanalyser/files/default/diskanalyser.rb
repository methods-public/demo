#!/bin/env rub
require 'English'
require 'json'
module Ohai
  module DiskAnalyser
    # Represents a physical disk
    class Disk
      attr_accessor :name, :type, :size, :model, :state,
                    :id, :number, :version, :partitions

      def device_path
        "/dev/#{name}"
      end

      def serial_number
        number.strip if number
      end

      def wnn
        id.delete(' ') if id
      end

      def initialize(lsblk_line)
        attrs_from_line lsblk_line
        check_smart_capability!
        check_health! if smart_capable?
        parse_smart_info if smart_capable?
        populate_partitions
      end

      def attrs_from_line(lsblk_line)
        %w(NAME TYPE SIZE MODEL STATE).each do |key|
          matches = lsblk_line.match(/#{key}="([^"]*)"/)
          send("#{key.downcase}=", matches[1]) if matches
        end
      end

      def smart_info
        shell_out("/usr/local/sbin/grab_smartctl.sh /dev/#{name} i").stdout
      end

      # Is the device SMART capable and enabled
      #
      def smart_capable?
        @smart_available && @smart_enabled
      end

      # Check the SMART health
      #
      def check_health!
        cmd = "/usr/local/sbin/grab_smartctl.sh #{device_path} H"
        output = shell_out(cmd).stdout
        @smart_healthy = !output.scan(/PASSED/).empty?
        @health_output = output
      end

      # Parses SMART drive info
      #
      def parse_smart_info
        %w(Id Number Version).each do |key|
          matches = @capability_output.match(/#{key}:\s+([^\n]*)\n/)
          send("#{key.downcase}=", matches[1]) if matches
        end
      end

      # Checks if disk is capable
      #
      def check_smart_capability!
        cmd = "/usr/local/sbin/grab_smartctl.sh #{device_path} i"
        output = shell_out(cmd).stdout
        @smart_available = !output.scan(/SMART support is: Available/).empty?
        @smart_enabled = !output.scan(/SMART support is: Enabled/).empty?
        @capability_output = output
      end

      def to_h
        parts = []
        partitions.each do |p|
          parts << p.to_h
        end
        {
          name: name, size: size, model: model,
          smart_available: @smart_available, smart_enabled: @smart_enabled,
          wnn: wnn, serial: serial_number, version: version, path: device_path,
          partitions: parts
        }
      end

      def populate_partitions
        self.partitions = []
        cmd = "ls #{device_path}[0-9]* 2>/dev/null"
        shell_out(cmd).stdout.each_line do |name|
          partitions << Partition.new(self, name)
        end
      end

      def shell_out(cmd)
        Ohai::Mixin::Command.shell_out(cmd)
      end
    end

    # Represents a disk Partition
    class Partition
      attr_accessor :disk, :name, :fs, :uuid, :uuid_sub, :type, :mounted
      BLKID_REGEX = %r[/dev/.*:\sUUID="(.{36})"\s(UUID_SUB="(.{36})"\s)*TYPE="(.*)"\s]
      def initialize(disk, name)
        self.disk = disk
        self.name = name.delete "\n"
        blkid
      end

      def ceph?
        mounted? && mounted.match(%r{/var/lib/ceph/})
      end

      def should_have_ceph?
        true
      end

      def mounted?
        !mounted.nil?
      end

      def fs?
        !fs.nil?
      end

      def to_h
        hash = { name: name, has_fs: fs? }
        return hash unless fs?
        hash[:uuid] = uuid
        hash[:uuid_sub] = uuid_sub
        hash[:type] = type
        hash[:mounted] = mounted?
        hash
      end

      def blkid
        process =  shell_out("blkid #{name}")
        response = process.stdout
        self.fs = process.exitstatus.zero?
        return unless fs?
        resp = response.scan(BLKID_REGEX)
        if resp && resp[0]
          self.uuid = resp[0][0]
          self.uuid_sub = resp[0][2]
          self.type = resp[0][3]
        end
        cmd = "grep #{name} /proc/mounts"
        mtab = shell_out(cmd).stdout
        self.mounted = mtab.split(' ')[1] if $CHILD_STATUS
      end

      def shell_out(cmd)
        Ohai::Mixin::Command.shell_out(cmd)
      end
    end

    # Reads disk configuration
    class Parser
      attr_accessor :devices
      def initialize
        self.devices = []
        populate
      end

      def to_h
        disks = {}
        devices.each do |d|
          disks[d.device_path] = d.to_h
        end
        { disks: disks }
      end

      def to_mash
        Mash.new to_h
      end

      private

      def shell_out(cmd)
        Ohai::Mixin::Command.shell_out(cmd)
      end

      def scan_disks
        ds = []
        cmd = 'lsblk -Pbdo NAME,TYPE,SIZE,MODEL,STATE'
        shell_out(cmd).stdout.each_line do |line|
          ds << Disk.new(line)
        end
        ds
      end

      def populate
        scan_disks.each do |d|
          devices << d
        end
      end
    end
  end
end

Ohai.plugin(:Diskanalyser) do
  provides 'diskanalyser'
  collect_data :default do
    Ohai::Log.debug('Loading data from sas2ircu')
    diskanalyser Ohai::DiskAnalyser::Parser.new.to_mash
  end
end
