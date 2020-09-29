require 'dhl_quotation/express/decoder'

module DHLQuotation
  module Express
    class Importer
      attr_reader :client

      def initialize
        @client = Client.new
      end

      def run(opts = {})
        opts[:account] ||= DHLQuotation.configuration.account
        payload = Payload.default(opts)
        resp = client.run(:get_rate_request, payload)
        Decoder.decode(resp.body).merge(
          country_code: opts.dig(:recipient, :country_code),
          weight: packages_weight(opts[:packages])
        )
      end

      def packages_weight(packages)
        packages.map { |p| p[:weight].to_f }.inject(:+)
      end
    end
  end
end
