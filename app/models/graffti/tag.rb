module Graffti
  class Tag < ActiveRecord::Base
    has_many :taggings, :dependent => :destroy

    before_save :to_lower_case

    def to_lower_case
      self.name = name.downcase
    end

    def self.find_or_create_by_name(name)
      if match = where(:name => name.downcase).first
        return match
      else
        create! :name => name
      end
    end
  end
end
