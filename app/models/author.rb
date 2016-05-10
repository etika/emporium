class Author < ActiveRecord::Base
  has_and_belongs_to_many :books ,association_foreign_key: 'book_id',join_table:'authors_books'
  validates_presence_of :first_name,:last_name
 def name
  "#{first_name} #{last_name}"
 end
end
