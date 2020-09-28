module DHLQuotation
  module Express
    class WorldImporter
      attr_accessor :importer

      def initialize(importer: Importer.new, interval: 3)
        @importer = importer
        @interval = interval
      end

      def run(opts = {})
        countries = DHLQuotation::Country.table
        countries.map do |c|
          result = import_and_format(c, opts.merge(recipient_format(c)))
          sleep @interval
          result
        end
      end

      def recipient_format(country_data)
        {
          recipient: {
            country_code: country_data[:iso],
            city: country_data[:capital],
            street_lines: country_data[:street_lines],
            postal_code: country_data[:postal_code]
          }
        }
      end

      def import_and_format(country_data, opts)
        result = { country_code: country_data[:iso], services: [], error: nil }
        begin
          result[:services] = importer.run(opts)
        rescue Savon::Error => e
          result[:error] = e.message
        end
        result
      end
    end
  end
end
