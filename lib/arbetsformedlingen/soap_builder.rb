# frozen_string_literal: true

require 'builder'

module Arbetsformedlingen
  class SOAPBuilder
    SOAP_ATTRIBUTES = {
      'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
      'xmlns:xsd' => 'http://www.w3.org/2001/XMLSchema',
      'xmlns:soap12' => 'http://www.w3.org/2003/05/soap-envelope',
    }.freeze

    def self.wrap(&block)
      new.wrap(&block)
    end

    def initialize
      @builder = Builder::XmlMarkup.new(indent: 2)
      @builder.instruct!

      yield self if block_given?
    end

    def wrap
      @builder.soap12(:Envelope, SOAP_ATTRIBUTES) do |envelope|
        envelope.soap12(:Body) { |body| yield(body) }
      end

      self
    end

    def to_xml
      @builder.target!
    end
  end
end
