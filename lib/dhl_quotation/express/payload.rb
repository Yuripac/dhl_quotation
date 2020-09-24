require 'dhl_quotation/express/content'

module DHLQuotation::Express
  class Payload

    class << self
      def default(opts={})
        country_code = opts[:recipient][:country_code]
        {
          requested_shipment: {
            drop_off_type: opts[:drop_off_type] || "REQUEST_COURIER",
            content:       opts[:content] || content(country_code),
            payment_info:  opts[:payment_info] || "DAP",
            account:       opts[:account],
            next_business_day: "Y",
            get_detailed_rate_breakdown: "Y",
            ship: {
              shipper: {
                street_lines: opts.dig(:shipper, :street_lines),
                country_code: opts.dig(:shipper, :country_code),
                city:         opts.dig(:shipper, :city),
                postal_code:  opts.dig(:shipper, :postal_code)
              },
              recipient: {
                street_lines: opts.dig(:recipient, :street_lines) || 'Something 999',
                country_code: opts.dig(:recipient, :country_code),
                city:         opts.dig(:recipient, :city),
                postal_code:  opts.dig(:recipient, :postal_code)
              }
            },
            packages: {
              requested_packages: [
                {
                  "@number": "1",
                  weight: {
                    value: opts.dig(:package, :weight)
                  },
                  dimensions: {
                    length: opts.dig(:package, :length),
                    width:  opts.dig(:package, :width),
                    height: opts.dig(:package, :height)
                  }
                }
              ]
            },
            ship_timestamp: opts[:ship_timestamp] || "#{Time.now.strftime("%Y-%m-%dT%H:%M:%S")}GMT+01:00", 
            unit_of_measurement: "SI"
          }
        }
      end
  
      def content(country_code)
        DHLQuotation::Express::Content.by_country_code(country_code)
      end
    end

  end
end