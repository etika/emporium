require 'test_helper'

class CartControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "test adding" do
  assert_difference(CartItem,:count) do
   post :add ,:id=>4
  end
  assert_response :redirect
  assert_redirected_to :controller=>"catalog"
  assert_equal 1,Cart.find(@request.session[:cart_id]).cart_items.size
end
test "test adding with xhr" do
  assert_difference(CartItem,:count) do
   xhr :post,:add,:id=>5
  end
  assert_response :success
  assert_equal 1,Cart.find(@request.session[:cart_id].cart_items.size)
end
test "test removing" do
  post :add ,:id=>4
  assert_equal [Book.find(4)],Cart.find(@request.session[:cart_id]).books
  post :remove ,:id=>4
  assert_equal [],Cart.find(@request.session[:cart_id]).books
end
test "test removing with xhr" do
  post :add,:id=>4
  assert_equal [Book.find(4)],Cart.find(@request.session[:cart_id]).books
  xhr :post,:remove,:id=>4
  assert_equal [],Cart.find(@request.session[:cart_id]).books
end
test "test clearing" do
 post :add,:id=>4
 assert_equal [Book.find(4)],Cart.find(@request.session[:cart_id]).books
 post :clear 
 assert_response :redirect
 assert_redirected_to :controller=> "catalog"
 assert_equal [],Cart.find(@request.session[:cart_id]).books
end
test "test clearing" do
 post :add,:id=>4
 assert_equal [Book.find(4)],Cart.find(@request.session[:cart_id]).books
 xhr :post, :clear 
 assert_response :redirect
 assert_redirected_to :controller=> "catalog"
 assert_equal [],Cart.find(@request.session[:cart_id]).cart_items.size
end
end
