require 'chef/mash'
require 'win32/registry' if RUBY_PLATFORM =~ /mswin|mingw32|windows/

module PCI
  # Provides methods to fetch PCI information on Windows
  module Windows
    unless constants.include?(:PNP_IDS)
      PNP_IDS = [
        /^PCI\\VEN_(?<vendor_id>\h{4})&DEV_(?<device_id>\h{4})&SUBSYS_(?<sdevice_id>\h{4})(?<svendor_id>\h{4})&REV_(?<rev>\h{2})$/,
        /^PCI\\VEN_(?<vendor_id>\h{4})&DEV_(?<device_id>\h{4})&CC_(?<class_id>\h{4})$/,
      ].freeze
    end
    LOCATION = /PCI bus %1, device %2, function %3;\((?<bus>\d+),(?<device>\d+),(?<function>\d+)\)$/ unless constants.include?(:LOCATION)

    # Parses PCI Location string to compose the PCI slot
    def self.slot(location_string)
      raise "[PCI] Invalid location string: '#{location_string}'" if location_string !~ LOCATION
      captures = ::Regexp.last_match

      bus = captures['bus'].to_i.to_s(16).rjust(2, '0')
      device = captures['device'].to_i.to_s(16).rjust(2, '0')
      function = captures['function']

      "0000:#{bus}:#{device}.#{function}"
    end

    # Parses PNP Ids to retrieve PCI information
    # See http://docs.microsoft.com/windows-hardware/drivers/install/identifiers-for-pci-devices
    def self.pnp_info(ids)
      scan_data = ids.flat_map { |id| PNP_IDS.map { |pattern| id.match pattern } }
      ::Mash.new(scan_data.compact.flat_map { |data| data.names.zip(data.captures.map(&:downcase)) }.to_h)
    end

    # Fetch available PCI devices instances from the registry
    def self.registry_instances
      pci = ::Win32::Registry::HKEY_LOCAL_MACHINE.open('SYSTEM\CurrentControlSet\Enum\PCI')
      pci.keys.flat_map do |device_key|
        device = pci.open(device_key)
        device.keys.map { |instance_key| device.open(instance_key) }
      end
    end

    # Retrieve all available PCI devices info
    def self.pci_devices
      ::Mash.new.tap do |result|
        registry_instances.each do |instance|
          pci_slot = slot instance['LocationInformation']
          result[pci_slot] = pnp_info(instance['HardwareID'])
          # Save the full PNPID in the result
          result[pci_slot]['pnp_id'] = instance.name[/PCI\\VEN_.*$/].upcase
        end
      end
    end
  end
end
