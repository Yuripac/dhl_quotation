require 'test_helper'
require "savon/mock/spec_helper"

describe DHLQuotation::Express::Client do
  let(:client) { DHLQuotation::Express::Client.new }

  describe '#connection' do
    it 'should return a savon client' do 
      con = client.connection
      exp_document = 'https://wsbexpress.dhl.com/sndpt/expressRateBook?WSDL'

      expect(con.wsdl.document).must_equal exp_document
    end
  end

  describe '#run' do
    it 'should call the savon method' do
      client.connection.stub(:call, 'success') do
        soap_result =
          client.run(:get_rate_request, {})
        expect(soap_result).must_equal 'success'
      end
    end
  end
end
