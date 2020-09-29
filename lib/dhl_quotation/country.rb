require 'yaml'

module DHLQuotation
  class Country
    FILE_PATH =
      File.expand_path('../../config/data/countries.yml', __dir__).freeze

    def self.table
      @table ||= load_data
    end

    def self.load_data
      YAML.safe_load(File.read(FILE_PATH), [Symbol])
    end
  end
end
