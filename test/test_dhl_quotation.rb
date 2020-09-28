describe DHLQuotation do
  describe '::configure' do
    it 'should set the configuration' do
      DHLQuotation.configure do |c|
        c.user = 'user123'
        c.password = '123'
        c.account = 'account123'
        c.taxable_countries = %w[FI]
      end

      config = DHLQuotation.configuration
      expect(config.user).must_equal 'user123'
      expect(config.password).must_equal '123'
      expect(config.account).must_equal 'account123'
      expect(config.taxable_countries).must_equal %w[FI]
    end
  end
end