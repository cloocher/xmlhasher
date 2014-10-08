require 'ox'
require 'escape_utils'

module XmlHasher
  class Handler < ::Ox::Sax
    def initialize(options = {})
      @options = options
      @stack = []
    end

    def to_hash
      @hash || {}
    end

    def start_element(name)
      @stack.push(Node.new(transform(name), @options[:ignore_attributes_on_content]))
    end

    def attr(name, value)
      unless ignore_attribute?(name)
        @stack.last.attributes[transform(name)] = escape(value) unless @stack.empty?
      end
    end

    def text(value)
      @stack.last.text = escape(value)
    end

    def end_element(name)
      if @stack.size == 1
        @hash = @stack.pop.to_hash
      else
        node = @stack.pop
        @stack.last.children << node
      end
    end

    private

    def transform(name)
      name = name.to_s.split(':').last if @options[:ignore_namespaces]
      name = Util.snakecase(name) if @options[:snakecase]
      name = name.to_sym unless @options[:string_keys]
      name
    end

    def escape(value)
      EscapeUtils.unescape_html(value)
    end

    def ignore_attribute?(name)
      @options[:ignore_namespaces] ? !name.to_s[/^(xmlns|xsi)/].nil? : false
    end
  end
end
