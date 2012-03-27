require 'test_helper'

module Graffiti
  class TagTest < ActiveSupport::TestCase
    def test_name_is_converted_to_lower_case
      tag = Tag.create! :name => 'UPLIFT'

      assert_equal 'uplift', tag.name
    end
  end
end
