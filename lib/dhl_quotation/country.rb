require 'yaml'

module DHLQuotation
  class Country
    FILE_PATH = 'config/data/countries.yml'.freeze

    def self.table
      @table ||= load_data
    end

    def self.load_data
      YAML.safe_load(File.read(FILE_PATH), [Symbol])
    end
  end
end
