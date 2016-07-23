class CheckoutController < ApplicationController
 before_filter :initialize_cart
  def index
    @order=Order.new
    @page_title="Checkout"
    if @cart.books.empty?
      flash[:notice]="Your shopping cart is empty!"
      redirect_to :controller=>"catalog"
    end
  end

  def place_order
   @page_title="Checkout"
   @order=Order.new(checkout_params)
   @order.customer_ip=request.remote_ip
   populate_order
   if @order.save
      if @order.process
        flash[:notice]='Your Order has been submitted and will be processed immediately'
        session[:order_id]=@order.id
        @cart.cart_items.destroy_all
        redirect_to :action=>'thank_you'
      else
        flash[:notice]='Error while placing order #{@order.error_message}'
        render :action=>'index'
      end
    else
        render :action=>'index'
    end

  end

  def thank_you
    @page_title ="Thank You"
  end

  private
  def checkout_params
      params.require(:order).permit(:email, :phone_number, :ship_to_first_name, :ship_to_last_name, :ship_to_address, :ship_to_city,:ship_to_postal_code, :ship_to_country,:card_type,:card_expiration_month,:card_expiration_year,:card_number,:card_verification_value)
  end
  def populate_order
    for cart_item in @cart.cart_items
      order_item=OrderItem.new(
        :book_id=>cart_item.book_id,
        :price=>cart_item.amount)
      @order.order_items << order_item
    end
  end

end
