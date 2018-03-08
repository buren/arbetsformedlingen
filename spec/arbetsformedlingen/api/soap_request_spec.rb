require 'spec_helper'

require 'arbetsformedlingen/api/soap_request'

RSpec.describe Arbetsformedlingen::API::SOAPRequest do
  describe '#initialize' do
    it 'raises ArgumentError if Nokogiri constant is not defined' do
      allow(Object).to receive(:const_defined?).and_return(false)
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it 'does not raise ArgumentError if Nokogiri constant is defined' do
      expect { described_class.new }.not_to raise_error(ArgumentError)
    end
  end

  describe '#parse_xml' do
    it 'returns a Nokogiri document' do
      request = described_class.new
      expect(request.parse_xml('')).to be_a(Nokogiri::XML::Document)
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

      request = described_class.new

      document = request.parse_xml(xml_with_namespace)
      result = document.css('Id').map(&:text)
      expect(result).to eq(%w[718])
    end
  end
end
