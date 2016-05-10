class CatalogController < ApplicationController
  def index
    @page_title="Book List"
    @books= Book.all
    # @book_pages,@books= paginate :books,:per_page=10,:include=>[:authors,:publisher],:order=>"book.id desc"
  end

  def show
    @book= Book.find(params[:id])
  end

  def search
  end

  def latest
    @page_title="Latest Book"
    @books =Book.latest
  end
  def rss
    latest
    render :layout=>false

  end
end
