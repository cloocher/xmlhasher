# frozen_string_literal: true

require 'ox'
require 'escape_utils'

module XmlHasher
  class Handler < ::Ox::Sax
    def initialize(options = {})
      @options = options
      @stack = []
      @transform_cache = {}

      super()
    end

    def to_hash
      @hash || {}
    end

    def start_element(name)
      @stack.push(Node.new(transform(name)))
    end

    def attr(name, value)
      return if ignore_attribute?(name) || @stack.empty?

      @stack.last.attributes[transform(name)] = escape(value)
    end

    def text(value)
      @stack.last.text = escape(value)
    end

    def cdata(str)
      @stack.last.text = escape(str)
    end

    def end_element(_name)
      if @stack.size == 1
        @hash = @stack.pop.to_hash
      else
        node = @stack.pop
        @stack.last.children << node
      end
    end

    private

    def transform(name)
      return @transform_cache[name] if @transform_cache[name]

      orig_name = name

      name = name.to_s.split(':').last if @options[:ignore_namespaces]
      name = Util.snakecase(name) if @options[:snakecase]
      name = @options[:string_keys] ? name.to_s : name.to_sym
      @transform_cache[orig_name] = name
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
