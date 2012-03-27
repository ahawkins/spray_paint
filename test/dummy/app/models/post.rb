class Post < ActiveRecord::Base
  include Graffti::Tags

  validates :name, :presence => true
end
