require 'dhl_quotation/country'

require 'dhl_quotation/core_ext/array/wrap'
require 'dhl_quotation/express/content'
require 'dhl_quotation/express/client'
require 'dhl_quotation/express/payload'
require 'dhl_quotation/express/decoder'
require 'dhl_quotation/express/importer'
require 'dhl_quotation/express/world_importer'

module DHLQuotation
  class << self
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  class Configuration
    attr_accessor :user, :password
    attr_accessor :account
    attr_accessor :taxable_countries
  end
end