class CreateBooksAndAuthorsBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.column :title,:string,:limit=>255,:null=>false
      t.column :publisher_id,:integer,:null=>false
      t.column :published_at ,:datetime
      t.column :isbn,:string,:limit=>13,:unique=>true
      t.column :blurb ,:text
      t.column :page_count ,:integer
      t.column :price,:float
      t.column :created_at,:timestamp
      t.column :updated_at, :timestamp
    end
    create_table :authors_books do |t|
      t.column :author_id ,:integer,:null=>false
      t.column :book_id,:integer,:null=>false
    end
  end

  def self.down
   drop_table :authors_books
   drop_table :books
  end
end
