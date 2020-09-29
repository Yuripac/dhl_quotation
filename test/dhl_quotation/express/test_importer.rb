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

      payload_complement = {
        account: '123',
        recipient: { country_code: 'FI', city: 'Helsinki' },
        packages: [{ weight: '1' }, { weight: '2.3' }]
      }
      payload = DHLQuotation::Express::Payload.default(payload_complement)
      importer = DHLQuotation::Express::Importer.new
      importer.client
              .expects(:run)
              .with(:get_rate_request, payload)
              .returns(client_result)
      result = importer.run(payload_complement)
      expect(result).must_equal(
        {
          country_code: 'FI',
          weight: 3.3,
          services: [
            {
              code: 'P',
              name: nil,
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