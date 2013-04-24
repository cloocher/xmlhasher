module XmlHasher
  module Util
    def self.snakecase(str)
      str.to_s.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z])([A-Z])/, '\1_\2').downcase
    end
  end
end
