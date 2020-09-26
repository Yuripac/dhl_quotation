require 'test_helper'

describe DHLQuotation::Express::Content do
  describe '#by_country_code' do
    let(:content) { DHLQuotation::Express::Content.new }
    it 'should return country as taxable' do
      content.taxable_countries = [:FI]
      expect(content.by_country_code(:FI)).must_equal 'DOCUMENTS'
    end

    it 'should return country as non taxable when it is not in the list' do
      expect(content.by_country_code(:FI)).must_equal 'NON_DOCUMENTS'
    end
  end
end
