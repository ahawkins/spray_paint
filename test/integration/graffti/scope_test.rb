require 'test_helper'

class ScopeTest < ActionDispatch::IntegrationTest
  def test_doesnt_match_anything
    post = Post.new :name => 'Test'
    post.tags = %w(melodic progressive)
    post.save!

    assert_empty Post.tagged('uplift')
  end

  def test_finds_by_one_tag
    post = Post.new :name => 'Test'
    post.tags = %w(melodic progressive)
    post.save!

    assert_not_empty Post.tagged('melodic')
  end

  def test_scope_acts_like_a_set
    melodic = Post.new :name => 'melodic'
    melodic.tags = %w(melodic progressive)
    melodic.save!

    uplift = Post.new :name => 'uplift'
    uplift.tags = %w(progressive uplift)
    uplift.save!

    assert_includes Post.tagged('melodic', 'progressive'), melodic
    assert_not_includes Post.tagged('melodic', 'progressive'), uplift

    assert_includes Post.tagged('uplift', 'progressive'), uplift
    assert_not_includes Post.tagged('uplift', 'progressive'), melodic
  end
end
