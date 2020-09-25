module DHLQuotation
  module Express
    class Content
      class << self
        TAXABLE     = 'DOCUMENTS'.freeze
        NON_TAXABLE = 'NON_DOCUMENTS'.freeze

        attr_accessor :taxable_countries

        def by_country_code(code)
          taxable_countries&.include?(code) ? TAXABLE : NON_TAXABLE
        end
      end
    end
  end
end
