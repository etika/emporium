class Admin::BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /admin/books
  # GET /admin/books.json
  def index
    load_data
    @books = Book.all
  end

  # GET /admin/books/1
  # GET /admin/books/1.json
  def show
  end

  # GET /admin/books/new
  def new
    load_data
    @book = Book.new
  end

  # GET /admin/books/1/edit
  def edit
    load_data
  end

  # POST /admin/books
  # POST /admin/books.json
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to [:admin, @book], notice: 'Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        load_data
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/books/1
  # PATCH/PUT /admin/books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to [:admin, @book], notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/books/1
  # DELETE /admin/books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to admin_books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :published_at, :isbn, :publisher_id, :blurb, :avatar,:page_count, :price,:author_ids=>[])
    end
    def load_data
    @authors=Author.all
    @publishers=Publisher.all
    end
end
