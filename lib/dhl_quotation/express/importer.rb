module DHLQuotation::Express
  class Importer

    def run(opts={})
      opts[:account] ||= Client.account
      
      payload = Payload.default(opts)
      Client.run(:get_rate_request, payload)
    end

  end
end