require 'test_helper'

class AssociationTest < ActionDispatch::IntegrationTest
  def test_active_record_associations
    post = Post.create! :name => 'Test'

    post.tags << Graffti::Tag.create!(:name => 'foo')

    assert_equal 1, post.tags.count

    assert_equal %w(foo), post.tags.names
  end

  def test_doesnt_delete_tag_model
    post = Post.create! :name => 'Test'

    post.tags << Graffti::Tag.create!(:name => 'foo')

    assert post.tags.clear

    assert Graffti::Tag.exists?
  end
end
