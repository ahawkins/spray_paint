class Post < ActiveRecord::Base
  include Graffiti::Tags

  validates :name, :presence => true
end
