require "graffti/engine"

module Graffti
  module Tags
    extend ActiveSupport::Concern

    included do
      has_many :taggings, :class_name => "Graffti::Tagging", :dependent => :destroy, :as => :taggable
      has_many :tags, :through => :taggings, :class_name => "Graffti::Tag", :source => :tag do
        def names
          pluck 'name'
        end

        def inspect
          names.inspect
        end

        def <<(*args)
          args.flatten.each do |tag|
            if tag.is_a? Graffti::Tag
              self.push tag
            else
              self.push Graffti::Tag.find_or_create_by_name tag
            end
          end
          self
        end

        def ==(other)
          names == other
        end
      end
    end

    def tags=(*args)
      tags.clear

      args.flatten.each do |tag|
        tags << tag
      end

      tags
    end
  end
end
