require 'savon'
require 'dhl_quotation/express/content'

module DHLQuotation
  module Express
    class Client
      WSDL_PATH = 'https://wsbexpress.dhl.com/sndpt/expressRateBook?WSDL'.freeze

      class << self
        attr_accessor :user, :password, :account, :taxable_countries

        def config
          yield self
          init_content
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

        def init_content
          DHLQuotation::Express::Content.taxable_countries = taxable_countries
        end
      end
    end
  end
end
