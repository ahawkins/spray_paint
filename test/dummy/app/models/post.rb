class Post < ActiveRecord::Base
  include SprayPaint::Tags

  validates :name, :presence => true
end
