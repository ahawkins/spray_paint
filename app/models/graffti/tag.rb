module Graffti
  class Tag < ActiveRecord::Base
    has_many :taggings, :dependent => :destroy

    def self.find_or_create_by_name(name)
      if match = where(["LOWER(graffti_tags.name) = ?", name.downcase]).first
        return match
      else
        create! :name => name
      end
    end
  end
end
