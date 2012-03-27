require 'test_helper'

class TaggingTest < ActionDispatch::IntegrationTest
  def test_can_add_tags
    post = Post.create! :name => 'Test'

    post.tags << 'epic'
    post.save!

    assert_equal %w(epic), post.tags
  end

  def test_can_add_tags_as_an_array
    post = Post.create! :name => 'Test'

    post.tags << %w(epic legit)
    post.save!

    assert_equal %w(epic legit), post.tags
  end

  def test_can_assign_tags_with_an_array
    post = Post.create! :name => 'Test'

    post.tags = %w(epic legit)
    post.save!

    assert_equal %w(epic legit), post.tags
  end

  def test_can_assign_tags_with_a_string
    post = Post.create! :name => 'Test'

    post.tags = 'epic'
    post.save!

    assert_equal %w(epic), post.tags
  end

  def test_handles_new_records
    post = Post.new :name => 'Test'

    post.tags = 'epic'
    post.save!

    assert_equal %w(epic), post.tags
  end

  def test_tag_names_are_not_case_senstive
    post = Post.create :name => 'Test'

    post.tags = %W(epic EPIC EpIc)
    post.save!

    assert_equal %w(epic), post.tags
  end

  def test_association_looks_like_an_array
    post = Post.create :name => 'Test'

    post.tags = %W(epic EPIC EpIc)
    post.save!

    assert_equal post.tags.names.inspect, post.tags.inspect
  end
end
