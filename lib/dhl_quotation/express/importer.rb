require 'dhl_quotation/express/decoder'

module DHLQuotation
  module Express
    class Importer
      def initialize
        @client = Client.new
      end

      def run(opts = {})
        opts[:account] ||= DHLQuotation.configuration.account
        payload = Payload.default(opts)
        resp = @client.run(:get_rate_request, payload)
        Decoder.decode(resp.body)
      end
    end
  end
end
