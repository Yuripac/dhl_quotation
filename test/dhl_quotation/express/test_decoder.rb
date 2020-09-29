require 'test_helper'

describe DHLQuotation::Express::Decoder do
  describe '::decode' do
    it 'should decode the response' do
      expected_result = {
        services: [
          {
            code: 'P',
            name: 'DHL WORLDWIDE',
            currency: 'EUR',
            amount: '20',
            deadline: '9'
          },
          {
            code: 'W',
            name: 'DHL MEDICAL',
            currency: 'EUR',
            amount: '30.45',
            deadline: '3'
          }
        ],
        errors: []
      }

      result = DHLQuotation::Express::Decoder.decode(decoder_params)
      expect(result).must_equal expected_result
    end

    it 'should return a empty services and errros when response has a not expected format' do
      data = DHLQuotation::Express::Decoder.decode({})
      expect(data).must_equal(services: [], errors: [])
    end

    it 'should return errors when it exists' do
      params = {
        rate_response: {
          provider: {
            notification: { message: 'random error', '@code': '999' }
          }
        }
      }

      data = DHLQuotation::Express::Decoder.decode(params)
      expect(data).must_equal(
        services: [],
        errors: [
          { message: 'random error', code: '999' }
        ]
      )
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