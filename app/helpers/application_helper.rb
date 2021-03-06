module ApplicationHelper
  def add_book_link(text,book)
    link_to text,cart_add_path(book)
end
  def remove_book_link(text,book)
    link_to text,{:url=>{:controller=>"cart",:action=>"remove",:id=>book}},{:title=>"Remove Cart",:href=>url_for(:controller=>"cart",:action=>"remove",:id=>book)},:remote=>true
  end
  def clear_cart_link(text = "Clear Cart")
    link_to text,{:url=>{:controller=>"cart",:action=>"clear"}},{:href=>url_for(:controller=>"cart",:action=>"clear",:id=>book)},:remote=>true
  end
end
