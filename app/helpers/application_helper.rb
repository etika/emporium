module ApplicationHelper
  def add_book_link(text,book)
    link_to text,cart_add_path(book),:remote=>true
end
  def remove_book_link(text,book)
    link_to text,cart_remove_path(book),:remote=>true
  end
  def clear_cart_link(text = "Clear Cart")
        link_to text,cart_clear_path,:remote=>true

    # link_to text,{:url=>{:controller=>"cart",:action=>"clear"}},{:href=>url_for(:controller=>"cart",:action=>"clear",:id=>book)},:remote=>true
  end
end
