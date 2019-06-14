# frozen_string_literal: true

require 'stringio'

module XmlHasher
  class Parser
    def initialize(options = {})
      @options = options
    end

    def parse(xml)
      handler = Handler.new(@options)
      Ox.sax_parse(handler, convert(xml))
      handler.to_hash
    end

    private

    def convert(xml)
      xml.respond_to?(:read) || xml.respond_to?(:readpartial) ? xml : StringIO.new(xml)
    end
  end
end
