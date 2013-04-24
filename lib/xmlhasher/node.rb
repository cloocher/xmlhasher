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
      if text
        h[name] = text
      else
        h[name] = attributes.inject({}) { |r, (key, value)| r[key] = value if !value.nil? && !value.to_s.empty?; r }
        if children.size == 1
          child = children.first
          h[name].merge!(child.to_hash)
        else
          if children.map(&:name).uniq.size == 1
            h[name].merge!(children.inject({}) { |r, child| (r[child.name] ||= []) << child.to_hash[child.name]; r })
          else
            h[name].merge!(children.inject({}) { |r, child| r.merge!(child.to_hash); r })
          end
        end
      end
      h[name] = nil if h[name].empty?
      h
    end
  end
end

