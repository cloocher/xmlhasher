module XmlHasher
  module Configurable

    attr_writer :snakecase, :ignore_namespaces

    KEYS = [:snakecase, :ignore_namespaces]

    def configure
      yield self
      self
    end

    private

    def options
      XmlHasher::Configurable::KEYS.inject({}) { |hash, key| hash[key] = instance_variable_get(:"@#{key}"); hash }
    end

  end
end
