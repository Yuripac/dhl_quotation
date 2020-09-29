module DHLQuotation
  module Express
    class Decoder
      class << self
        def decode(data)
          provider = data.dig(:rate_response, :provider)
          services = Array.wrap(provider&.dig(:service))
          {
            services: services.map do |s|
              {
                code: s[:@type],
                name: s[:service_name],
                currency: s.dig(:total_net, :currency),
                amount: s.dig(:total_net, :amount),
                deadline: s[:total_transit_days],
              }
            end,
            errors: error_messages(provider&.dig(:notification))
          }
        end

        def error_messages(notification)
          notifications = Array.wrap(notification)
          return [] if notifications.any? { |n| n[:message].nil? }

          notifications.map { |n| { message: n[:message], code: n[:@code] } }
        end
      end
    end
  end
end
