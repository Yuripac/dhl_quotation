require 'test_helper'

describe DHLQuotation::Express::WorldImporter do
  describe '#run' do
    let(:finland) { countries_data.first }
    let(:france) { countries_data.last }

    it 'should run for all the countries' do
      world_importer = DHLQuotation::Express::WorldImporter.new(interval: 0)
      importer = world_importer.importer
      importer.stubs(:run)
              .with(recipient_data(finland))
              .returns(services: %w[fi_p fi_u])

      importer.stubs(:run)
              .with(recipient_data(france))
              .returns(services: %w[fr_p fr_u])
      DHLQuotation::Country.stub(:table, countries_data) do
        result = world_importer.run
        expect(result).must_equal(
          [
            { country_code: finland[:iso], services: %w[fi_p fi_u], request_error: nil },
            { country_code: france[:iso], services: %w[fr_p fr_u], request_error: nil }
          ]
        )
      end
    end

    it 'should return the error message' do
      world_importer = DHLQuotation::Express::WorldImporter.new(interval: 0)
      importer = world_importer.importer
      importer.stubs(:run).raises(Savon::Error, 'random error')
      DHLQuotation::Country.stub(:table, [finland]) do
        result = world_importer.run
        expect(result).must_equal(
          [
            { country_code: finland[:iso], services: [], request_error: 'random error' }
          ]
        )
      end
    end
  end
end

def recipient_data(country)
  {
    recipient: {
      country_code: country[:iso],
      city: country[:capital],
      street_lines: country[:street_lines],
      postal_code: country[:postal_code]
    }
  }
end

def countries_data
  [
    {
      name: 'Finland',
      capital: 'Helsinki',
      iso: 'FI',
      postal_code: '33840'
    },
    {
      name: 'France',
      capital: 'Paris',
      iso: 'FR',
      postal_code: '13300'
    }
  ]
end