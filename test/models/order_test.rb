require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
def test_that_we_can_create_a_valid_order
order=Order.new(
  :email=>,
  :phone_number=>,
  :ship_to_first_name=>'Hallon',
  :ship_to_last_name=>'Saft',
  :ship_to_address=>'Street',
  :ship_to_city=>'City',
  :ship_to_postal_code=>'Code',
  :ship_to_country=>'Iceland',
  :card_type=>'Visa',
  :card_number=>'400700000027',
  :card_expiration_month=>'1',
  :card_expiration_year=>'2009',
  :card_verification_value=>'333'
  )
order.customer_ip='10.0.0.1'
order.status= 'processed'
order.order_items<<OrderItem.new(:book_id=>1,
  :price=>100.666,
  :amount=>13)
assert order.save
order.reload
assert_equal 1,order.order_items.size
assert_equal 100.666,order.order_items[0].price
end

def test_that_validation_works
  order=Order.new
  assert_equal false,order.save
  # An order should have on order item'
  assert orders.errors.on(:order_items)
  assert_equal 15,order.errors.size
  assert orders.errors.on(:email) 
  assert orders.errors.on(:phone_number)
  assert orders.errors.on(:ship_to_first_name)
  assert orders.errors.on(:ship_to_last_name)
  assert orders.errors.on(:ship_to_address)
  assert orders.errors.on(:ship_to_postal_code)
  assert orders.errors.on(:ship_to_country)
  assert orders.errors.on(:card_type)
  assert orders.errors.on(:card_number)
  assert orders.errors.on(:card_expiration_year)
  assert orders.errors.on(:card_expiration_month)
  assert orders.errors.on(:card_verification_value)
  assert orders.errors.on(:customer_ip)

end
end
