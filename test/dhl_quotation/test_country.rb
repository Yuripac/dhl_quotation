require 'test_helper'

describe DHLQuotation::Country do
  describe '::table' do
    it 'should load country table' do
      table = DHLQuotation::Country.table
      row = table.first

      expect(table.size).must_equal 250
      expect(row[:name]).wont_be_nil
      expect(row[:capital]).wont_be_nil
      expect(row[:iso]).wont_be_nil
      expect(row[:postal_code]).wont_be_nil
    end
  end
end
