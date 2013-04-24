require 'ox'

module XmlHasher
  class Parser

    def initialize(options = {})
      @options = options
    end

    def parse(xml)
      handler = XmlHasher::Handler.new
      Ox.sax_parse(handler, xml)
      handler.to_hash
    end
  end
end
