# frozen_string_literal: true

require 'spec_helper'

require 'arbetsformedlingen/soap_builder'

RSpec.describe Arbetsformedlingen::SOAPBuilder do
  it 'can wrap body in SOAP markup' do
    builder = Arbetsformedlingen::SOAPBuilder.wrap do |body|
      body.GetAllOccupationsShort(xmlns: 'urn:ams.se:wsoccupation')
    end

    body = <<~XMLDATA
      <?xml version=\"1.0\" encoding=\"UTF-8\"?>
      <soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">
        <soap12:Body>
          <GetAllOccupationsShort xmlns=\"urn:ams.se:wsoccupation\"/>
        </soap12:Body>
      </soap12:Envelope>
    XMLDATA

    expect(builder.to_xml).to eq(body)
  end

  it 'raises error if no block is given' do
    expect { Arbetsformedlingen::SOAPBuilder.wrap }.to raise_error(LocalJumpError)
  end
end
