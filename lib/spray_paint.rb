require "spray_paint/engine"
require "digest/sha1"

module SprayPaint
  module Tags
    extend ActiveSupport::Concern

    included do
      has_many :taggings, :class_name => "SprayPaint::Tagging", :dependent => :destroy, :as => :taggable
      has_many :tags, :through => :taggings, :class_name => "SprayPaint::Tag", :source => :tag do
        def names
          pluck 'name'
        end

        def inspect
          names.inspect
        end

        def <<(*args)
          args.flatten.map(&:downcase).uniq.each do |tag|
            self.push SprayPaint::Tag.find_or_create_by_name(tag) unless tagged?(tag)
          end
          self
        end

        def ==(other)
          names == other
        end

        private
        def tagged?(name)
          names.include?(name.downcase)
        end
      end

      def self.tagged(*tags)
        tags.flatten.inject scoped do |scope, tag|
          uniq_key = Digest::SHA1.hexdigest("#{Time.now.to_i}-#{tag}")[0..5]

          join_table = "tag_#{uniq_key}"
          tagging_table = "tagging_#{uniq_key}"

          taggings_join = %Q{
            INNER JOIN spray_paint_taggings AS #{tagging_table} 
            ON #{table_name}.id = #{tagging_table}.taggable_id AND #{tagging_table}.taggable_type = '#{base_class.to_s}'
          }

          tag_join = "INNER JOIN spray_paint_tags AS #{join_table} ON #{join_table}.id = #{tagging_table}.tag_id"

          scope.joins(taggings_join).joins(tag_join).where(join_table.to_sym => {:name => tag.downcase}) 
        end
      end
    end

    def tags=(*args)
      tags.clear

      tags << args

      tags
    end
  end
end
