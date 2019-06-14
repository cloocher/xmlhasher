# frozen_string_literal: true

module XmlHasher
  class Node
    attr_accessor :name, :attributes, :children, :text

    def initialize(name)
      @name = name
      @attributes = {}
      @children = []
    end

    def to_hash
      h = {}
      if text && !text.empty?
        h[name] = text
      else
        h[name] = attributes.each_with_object({}) { |(key, value), r| r[key] = value if !value.nil? && !value.to_s.empty?; }
        if children.size == 1
          h[name].merge!(children.first.to_hash)
        else
          h[name].merge!(children.group_by(&:name).each_with_object({}) { |(k, v), r| v.length == 1 ? r.merge!(v.first.to_hash) : r[k] = v.map { |c| c.to_hash[c.name] }; })
        end
      end
      h[name] = nil if h[name].empty?
      h
    end
  end
end
