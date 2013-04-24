require 'ox'

module XmlHasher
  class Handler < ::Ox::Sax
    def initialize(options = {})
      @options = options
      @stack = []
    end

    def to_hash
      @hash
    end

    def start_element(name)
      puts "start: #{name}"
      @stack.push(XmlHasher::Node.new(name))
    end

    def attr(name, value)
      puts "  #{name} => #{value}"
      @stack.last.attributes[name] = value
    end

    def text(value)
      puts "text: #{value}"
      @stack.last.text = value
    end

    def end_element(name)
      puts "end: #{name}"
      if @stack.size == 1
        @hash = @stack.pop.to_hash
      else
        node = @stack.pop
        @stack.last.children << node
      end
    end
  end
end
