require 'dhl_quotation/express/content'

module DHLQuotation
  module Express
    class Payload
      class << self
        def default(opts = {})
          country_code = opts[:recipient][:country_code]
          {
            requested_shipment: {
              drop_off_type: opts[:drop_off_type] || 'REQUEST_COURIER',
              content: opts[:content] || default_content(country_code),
              payment_info: opts[:payment_info] || 'DAP',
              account: opts[:account],
              next_business_day: 'Y',
              get_detailed_rate_breakdown: 'Y',
              ship: {
                shipper: opts[:shipper], # Set a default street line
                recipient: opts[:recipient].merge(street_lines: 'street 999')
              },
              packages: packages(opts[:packages]),
              ship_timestamp: opts[:ship_timestamp] || default_ship_timestamp,
              unit_of_measurement: 'SI'
            }
          }
        end

        def packages(packages)
          {
            requested_packages: packages.map.with_index(1) do |package, i|
              {
                '@number': i,
                weight: { value: package[:weight] },
                dimensions: {
                  length: package[:length],
                  width: package[:width],
                  height: package[:height]
                }
              }
            end
          }
        end

        def default_ship_timestamp
          "#{Time.now.strftime('%Y-%m-%dT%H:%M:%S')}GMT+01:00"
        end

        def default_content(country_code)
          DHLQuotation::Express::Content.by_country_code(country_code)
        end
      end
    end
  end
end
