actions :install, :remove
default_action :install

attribute :path, kind_of: String, name_attribute: true
attribute :className, kind_of: String, default: 'de.javakaffee.web.msm.MemcachedBackupSessionManager'
attribute :memcachedNodes, kind_of: String, required: true
attribute :failoverNodes, kind_of: [String, NilClass], default: nil
attribute :username, kind_of: [String, NilClass], default: nil
attribute :password, kind_of: [String, NilClass], default: nil
attribute :memcachedProtocol, kind_of: String, default: 'text', equal_to: %w(text binary)
attribute :sticky, kind_of: [TrueClass, FalseClass], default: true
attribute :lockingMode, kind_of: String, default: 'none'
attribute :requestUriIgnorePattern, kind_of: [String, NilClass], default: nil
attribute :sessionBackupAsync, kind_of: [TrueClass, FalseClass], default: true
attribute :backupThreadCount, kind_of: [String, NilClass], default: nil
attribute :sessionBackupTimeout, kind_of: Integer, default: 100
attribute :operationTimeout, kind_of: Integer, default: 1000
attribute :storageKeyPrefix, kind_of: String, default: 'webappVersion'
attribute :sessionAttributeFilter, kind_of: [String, NilClass], default: nil
attribute :transcoderFactoryClass, kind_of: String, default: 'de.javakaffee.web.msm.JavaSerializationTranscoderFactory'
attribute :copyCollectionsForSerialization, kind_of: [TrueClass, FalseClass], default: false
attribute :customConverter, kind_of: [String, NilClass], default: nil
attribute :enableStatistics, kind_of: [TrueClass, FalseClass], default: true
attribute :enabled, kind_of: [TrueClass, FalseClass], default: true
