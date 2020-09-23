require 'yaml'

module DHLQuotation
  class Country
    FILE_PATH = 'config/data/countries.yml'

    def self.table
      @table ||= load_data
    end
  
    def self.load_data
      YAML.load(File.read(FILE_PATH))
    end
  
  end
end