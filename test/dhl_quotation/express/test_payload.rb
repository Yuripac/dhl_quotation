require 'test_helper'

describe DHLQuotation::Express::Payload do
  describe '::default' do
    let(:payload) { DHLQuotation::Express::Payload }

    it 'should return a filled payload with set and default values' do
      current_time = Time.now

      Time.stub(:now, current_time) do
        expect(expected_payload).must_equal payload.default(payload_params)
      end
    end
  end
end

def expected_payload
  {
    requested_shipment: {
      drop_off_type: 'REQUEST_COURIER',
      content: 'NON_DOCUMENTS',
      payment_info: 'DAP',
      account: '123456',
      next_business_day: 'Y',
      get_detailed_rate_breakdown: 'Y',
      ship: {
        shipper: {
          street_lines: 'Street 123',
          country_code: 'FI',
          city: 'Helsinki',
          postal_code: '33840'
        },
        recipient: {
          street_lines: 'street 999',
          country_code: 'NL',
          city: 'Amsterdam',
          postal_code: '4301 ZZ'
        }
      },
      packages: {
        requested_packages: [
          {
            '@number': 1,
            weight: { value: 0.1 },
            dimensions: {
              length: 0.1,
              width: 0.1,
              height: 0.1
            }
          },
          {
            '@number': 2,
            weight: { value: 0.2 },
            dimensions: {
              length: 0.2,
              width: 0.2,
              height: 0.2
            }
          }
        ]
    },
      ship_timestamp: Time.now.strftime('%Y-%m-%dT%H:%M:%SGMT+01:00'),
      unit_of_measurement: 'SI'
    }
  }
end


def payload_params
  {
    account: '123456',
    shipper: {
      street_lines: 'Street 123',
      country_code: 'FI',
      city: 'Helsinki',
      postal_code: '33840'
    },
    recipient: {
      street_lines: nil,
      country_code: 'NL',
      city: 'Amsterdam',
      postal_code: '4301 ZZ'
    },
    packages: [
      {
        weight: 0.1,
        length: 0.1,
        width: 0.1,
        height: 0.1
      },
      {
        weight: 0.2,
        length: 0.2,
        width: 0.2,
        height: 0.2
      }
    ]
  }
end