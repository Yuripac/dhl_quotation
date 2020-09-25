module DHLQuotation
  module Express
    class WorldImporter
      attr_accessor :importer

      def initialize(importer = nil)
        @importer = importer || Importer.new
      end

      def run(opts = {})
        countries = DHLQuotation::Country.table
        countries.each_slice(60).flat_map do |c_group|
          result = c_group.map do |c|
            import_and_format(c, opts.merge(recipient_format(c)))
          end
          sleep 60
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
        {
          country_code: country_data[:iso],
          services: importer.run(opts)
        }
      end
    end
  end
end
