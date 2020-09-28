require 'test_helper'

describe DHLQuotation::Express::Importer do
  describe '#run' do
    it 'should get the quotes' do
      client_result = OpenStruct.new(
        body: {
          rate_response: {
            provider: {
              service: [
                {
                  '@type': 'P',
                  total_transit_days: '3',
                  total_net: { amount: '21.3' }
                }
              ]
            }
          }
        }
      )
      payload = DHLQuotation::Express::Payload.default(account: '123')
      importer = DHLQuotation::Express::Importer.new
      importer.client
              .expects(:run)
              .with(:get_rate_request, payload)
              .returns(client_result)
      result = importer.run(account: '123')
      expect(result).must_equal(
        {
          services: [
            {
              service: 'P',
              service_name: nil,
              currency: nil,
              amount: '21.3',
              deadline: '3'
            }
          ],
          errors: []
        }
      )
    end
  end
end