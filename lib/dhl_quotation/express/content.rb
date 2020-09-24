module DHLQuotation::Express
  class Content

    class << self
      TAXABLE     = 'DOCUMENTS'
      NON_TAXABLE = 'NON_DOCUMENTS'

      attr_accessor :taxable_countries

      def by_country_code(code)
        taxable_countries&.include?(code) ? TAXABLE : NON_TAXABLE
      end

    end
  end
end