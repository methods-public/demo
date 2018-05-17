require 'chef/mash'

module PCI
  # Provides methods to fetch PCI information on Linux
  module Linux
    def self.slot(device_path)
      ::File.basename device_path
    end

    # Read PCI ids from the device configuration space
    # See https://upload.wikimedia.org/wikipedia/commons/c/ca/Pci-config-space.svg
    # N.B. One byte of the class ID is ignored
    def self.read_values(path)
      ::Mash.new.tap do |result|
        data = ::File.binread(::File.join(path, 'config'), 48).unpack('vvx4cxvx32vv')
        %i[vendor_id device_id rev class_id svendor_id sdevice_id].zip(data).each do |key, value|
          length = key == :rev ? 2 : 4
          result[key] = value.to_s(16).rjust(length, '0')
        end
      end
    end

    # Retrieve all available PCI devices info
    def self.pci_devices
      ::Mash.new.tap do |result|
        ::Dir['/sys/bus/pci/devices/*'].each { |path| result[slot(path)] = read_values(path) }
      end
    end
  end
end
