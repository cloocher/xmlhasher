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
        if children.size == 1
          child = children.first
          h[child.name] = child.to_hash
        else
          if children.map(&:name).uniq.size == 1
            h[name] = children.map { |child| child.to_hash }
          else
            children.each do |child|
              h[child.name] = child.to_hash
            end
          end
        end
      end
      attributes.each do |key, value|
        h[key] = value if value
      end
      h
    end
  end
end

