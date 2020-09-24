module DHLQuotation::Express
  class Decoder

    def self.decode(data)
      data = data.dig(:rate_response, :provider, :service)
      return [] if data.nil?
      
      data.map do |d|
        {
          service:      d[:@type],
          service_name: d[:service_name],
          currency:     d.dig(:total_net, :currency),
          amount:       d.dig(:total_net, :amount),
          deadline:     d[:total_transit_days]
        }
      end
    end

  end
end