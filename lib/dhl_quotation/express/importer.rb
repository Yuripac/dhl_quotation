require 'dhl_quotation/express/decoder'

module DHLQuotation
  module Express
    class Importer
      def run(opts = {})
        opts[:account] ||= Client.account

        payload = Payload.default(opts)
        resp = Client.run(:get_rate_request, payload)
        Decoder.decode(resp.body)
      end
    end
  end
end
