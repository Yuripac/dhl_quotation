module DHLQuotation
  module Express
    class Decoder
      def self.decode(data)
        return [] unless (data = data.dig(:rate_response, :provider, :service))

        data.map do |d|
          {
            service: d[:@type],
            service_name: d[:service_name],
            currency: d.dig(:total_net, :currency),
            amount: d.dig(:total_net, :amount),
            deadline: d[:total_transit_days]
          }
        end
      end
    end
  end
end
