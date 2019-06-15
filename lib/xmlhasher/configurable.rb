# frozen_string_literal: true

module XmlHasher
  module Configurable
    attr_writer :snakecase, :ignore_namespaces, :string_keys

    KEYS = %i[snakecase ignore_namespaces string_keys].freeze

    def configure
      yield self
      self
    end

    private

    def options
      XmlHasher::Configurable::KEYS.each_with_object({}) do |key, hash|
        hash[key] = instance_variable_get(:"@#{key}");
      end
    end
  end
end
