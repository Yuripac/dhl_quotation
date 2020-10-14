require 'savon'

module DHLQuotation
  module Express
    class Client
      WSDL_PATH = 'https://wsbexpress.dhl.com/gbl/expressRateBook?WSDL'.freeze

      def initialize(opts = {})
        config = DHLQuotation.configuration
        @user = opts[:user] || config.user
        @password = opts[:password] || config.password
      end

      def run(method, params)
        connection.call(method, message: params)
      end

      def connection
        @connection ||= Savon.client(
          wsdl: WSDL_PATH,
          wsse_auth: [@user, @password],
          log: true,
          pretty_print_xml: true,
          convert_request_keys_to: :camelcase
        )
      end
    end
  end
end
