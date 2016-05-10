require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  fixtures :authors
  def test_name
    author = Author.create(:first_name=>"Joel",:last_name=>"Spolsky")
    assert_equal 'Joel Spolsky',author.name
  end
  # test "the truth" do
  #   assert true
  # end
end
