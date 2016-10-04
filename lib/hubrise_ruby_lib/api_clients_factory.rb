module Hubrise
  class APIClientsFactory
    VERSIONS_HASH = {}

    def self.register_version(version, version_class)
      VERSIONS_HASH[version] = version_class
    end

    def self.versions
      VERSIONS_HASH.keys
    end

    def self.build(app_id, app_secret, version, options = {})
      if version_class = VERSIONS_HASH[version]
        version_class.new(app_id, app_secret, options)
      else
        raise "Version is not available: #{version}"
      end
    end
  end
end