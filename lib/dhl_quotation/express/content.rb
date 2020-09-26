module DHLQuotation
  module Express
    class Content
      TAXABLE     = 'DOCUMENTS'.freeze
      NON_TAXABLE = 'NON_DOCUMENTS'.freeze

      attr_accessor :taxable_countries

      def initialize(opts = {})
        config = DHLQuotation.configuration
        @taxable_countries =
          opts[:taxable_countries] || config.taxable_countries
      end

      def by_country_code(code)
        taxable_countries&.include?(code) ? TAXABLE : NON_TAXABLE
      end
    end
  end
end
