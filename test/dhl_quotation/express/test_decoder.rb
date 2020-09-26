require 'test_helper'

describe DHLQuotation::Express::Decoder do
  describe '::decode' do
    it 'should decode the response' do
      expected_result = [
        {
          service: 'P',
          service_name: 'DHL WORLDWIDE',
          currency: 'EUR',
          amount: '20',
          deadline: '9'
        },
        {
          service: 'W',
          service_name: 'DHL MEDICAL',
          currency: 'EUR',
          amount: '30.45',
          deadline: '3'
        }
      ]

      result = DHLQuotation::Express::Decoder.decode(decoder_params)
      expect(result).must_equal expected_result
    end

    it 'should return a empty array when response has a not expected format' do
      data = DHLQuotation::Express::Decoder.decode({})
      expect(data).must_equal []
    end
  end
end

def decoder_params
  {
    rate_response: {
      provider: {
        service: [
          {
            '@type': 'P',
            service_name: 'DHL WORLDWIDE',
            total_transit_days: '9',
            total_net: { amount: '20', currency: 'EUR' }
          },
          {
            '@type': 'W',
            service_name: 'DHL MEDICAL',
            total_transit_days: '3',
            total_net: { amount: '30.45', currency: 'EUR' }
          }
        ]
      }
    }
  }
end