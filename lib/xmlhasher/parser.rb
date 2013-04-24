require 'stringio'

module XmlHasher
  class Parser

    def initialize(options = {})
      @options = options
    end

    def parse(xml)
      handler = XmlHasher::Handler.new
      Ox.sax_parse(handler, convert(xml))
      handler.to_hash
    end

    private

    def convert(xml)
      xml.respond_to?(:read) && xml.respond_to?(:readpartial) ? StringIO.new(xml) : xml
    end
  end
end
