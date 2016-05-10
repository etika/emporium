require 'test_helper'
Class BookTest < ActionController::IntegrationTest
    def test_book_administration
      publisher= Publisher.create(:name=>"Books for dummies")
      author =Author.create(:first_name=>'Bodo',:last_name=>'Bar')
      george=new_session_as(:george)
      ruby_for_dummies=george.add_book :book=>{
        :title=>"Ruby for Dummies",
        :publisher_id=>publisher.id,
        :author_ids =>[author.id],
        :published_at=>Time.now,
        :isbn=>'123-123-123-X',
        :blurb=>'The best book released since "Eating with Dummies"',
        :page_count=>123,
        :price=>40.4
      }
      george.list_books
      george.show_books ruby_for_dummies
    end
    def test_ferret
      Book.rebuild_index
      assert Book.find_by_contents("Pride and Prejudice")
      assert_difference Book,:count do
      book=Book.new(:title=>"The Success of Open Source",:published_at=>Time.now,:page_count=>500,:price=>59.99,:isbn=>'0-674-01292-5')
      book.authors << Author.create(:first_name=>"Steven",:last_name=>"Weber")
      book.publisher=Publisher.find(1)
      assert book.valid?
      book.save
      assert_equal 1,Book.find_by_contents("Open Source").size
      assert_equal 1,Book.find_by_contents("Steven Weber").size
      end
    end


  private
      module BookTestDSL
        attr_writer :name
            def add_book(parameters)
              author = Author.first
              publisher = Publisher.first
              get "admin/book/new"
              assert_response :success
              assert_template "admin/book/new"
              assert_tag :tag=>'option',:attributes=>{:value=>publisher.id}
              assert_tag :tag=>'select',:attributes=>{:id=>'book[author_ids][]'}
              post "/admin/book/create",parameters
              assert_response :redirect
              follow_redirect!
              assert_response :success
              assert_template "admin/book/list"
              assert_tag :tag=>'td',:content=>parameters[:book][:title]
              george.edit_book(ruby_for_dummies,:book=>{
                :title=>'Ruby for Toddlers',
                :publisher_id=>publisher.id,
                :author_ids=>[author.id],
                :published_at=>Time.now,
                :isbn=>'123-123-123-X',
                 :blurb=>"The best book released since Eating for Toddlers",
                 :page_count=>123,
                 :price=>40.4
                })
              bob=new_session_as(:bob)
              bob.delete_book ruby_for_dummies
              return Book.find_by_title(parameters[:book][:title])
            end
            def list_books
              get "/admin/book/"
              assert_response :success
              assert_template "admin/book/list"
            end
            def show_books
              get "/admin/book/show/#{book.id}"
              assert_response :success
              assert_template "admin/book/show"
           end
           def edit_book(book,parameters)
              get "/admin/book/edit/#{book.id}"
              assert_response :success
              assert_template "admin/book/edit"
              post "/admin/book/update/#{book.id}",parameters
              assert_response :redirect
              follow_redirect!
              assert_response :success
              assert_template "admin/book/show"
           end
           def delete_book(book)
             post "/admin/book/destroy/#{book.id}"
             assert_response :redirect
             follow_redirect!
             assert_template "admin/book/list"
           end
       end
      def new_session_as(name)
        open_session do |session|
          session.extend(BookTestDSL)
          session.name = name
          yield session if block_given?
         end
      end
end