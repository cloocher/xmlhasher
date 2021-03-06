# frozen_string_literal: true

require 'xmlhasher/configurable'
require 'xmlhasher/handler'
require 'xmlhasher/parser'
require 'xmlhasher/node'
require 'xmlhasher/util'
require 'xmlhasher/version'

module XmlHasher
  class << self
    include XmlHasher::Configurable

    def parser
      @parser ||= XmlHasher::Parser.new(options)
    end

    private

    def method_missing(method_name, *args, &block)
      return super unless parser.respond_to?(method_name)

      parser.send(method_name, *args, &block)
    end

    def respond_to_missing?(method_name, include_private = false)
      super
    end
  end
end
