module XmlHasher
  class Node
    attr_accessor :name, :attributes, :children, :text

    def initialize(name, ignore_attributes_on_content = false)
      @name = name
      @attributes = {}
      @children = []
      @ignore_attributes_on_content = ignore_attributes_on_content
    end

    def to_hash
      h = {}
      if text
        if should_ignore_attributes_on_content?
          h[name] = text
        else
          h[name] = clean_attributes.merge(value: text)
        end
      else
        h[name] = clean_attributes
        if children.size == 1
          child = children.first
          h[name].merge!(child.to_hash)
        else
          h[name].merge!(children.group_by { |child| child.name }.inject({}) { |r, (k, v)| v.length == 1 ? r.merge!(v.first.to_hash) : r[k] = v.map { |c| c.to_hash[c.name] }; r })
        end
      end
      h[name] = nil if h[name].empty?
      h
    end

    private

    def should_ignore_attributes_on_content?
      @ignore_attributes_on_content || clean_attributes.empty?
    end

    def clean_attributes
      return @clean_attributes if @clean_attributes
      @clean_attributes = attributes.inject({}) { |r, (key, value)| r[key] = value if !value.nil? && !value.to_s.empty?; r }
    end
  end
end
