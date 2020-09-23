require 'savon'

module DHLQuotation::Express
  class Client
    WSDL_PATH = 'https://wsbexpress.dhl.com/sndpt/expressRateBook?WSDL'

    class << self
      attr_accessor :user, :password, :account
      
      def config
        yield self 
      end

      def run(method, params)
        connection.call(method, message: params)
      end

      def connection
        @connection ||= Savon.client(
          wsdl: WSDL_PATH,
          wsse_auth: [user, password],
          log: true,
          pretty_print_xml: true,
          convert_request_keys_to: :camelcase
        )
      end
    end

  end
end