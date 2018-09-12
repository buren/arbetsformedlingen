require 'spec_helper'

require 'arbetsformedlingen/api/response'

RSpec.describe Arbetsformedlingen::API::Response do
  describe '#success?' do
    it 'returns true when response code is 200' do
      response = described_class.new(Struct.new(:code).new('200'))

      expect(response.success?).to eq(true)
    end

    it 'returns false when response code is 500' do
      response = described_class.new(Struct.new(:code).new('500'))

      expect(response.success?).to eq(false)
    end
  end

  context 'delegates missing' do
    it 'returns response value' do
      response = described_class.new(Struct.new(:some_method).new(true))

      expect(response.some_method).to eq(true)
    end

    it 'raises when no method does not exist on response' do
      response = described_class.new(Struct.new(:some_method).new(true))

      expect do
        response.other_method
      end.to raise_error(NoMethodError)
    end
  end

  context 'xml' do
    it 'returns a Nokogiri document' do
      response = Struct.new(:read_body).new('')
      request = described_class.new(response)
      expect(request.xml).to be_a(Nokogiri::XML::Document)
    end

    it 'returns a Nokogiri document with namespaces removed' do
      xml_with_namespace = <<~XMLDATA
        <?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
          <soap:Body>
            <GetAllOccupationsShortResponse xmlns="urn:ams.se:wsoccupation">
              <OccupationsShort>
                <OccupationShort>
                  <Id>718</Id>
                  <Name>Landskapsarkitekter och landskapsingenjörer</Name>
                </OccupationShort>
              </OccupationsShort>
            </GetAllOccupationsShortResponse>
          </soap:Body>
        </soap:Envelope>
      XMLDATA

      response = Struct.new(:read_body).new(xml_with_namespace)
      request = described_class.new(response)

      document = request.xml
      result = document.css('Id').map(&:text)
      expect(result).to eq(%w[718])
    end
  end
end
