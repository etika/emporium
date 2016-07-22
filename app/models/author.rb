class Author < ActiveRecord::Base
  has_and_belongs_to_many :books ,association_foreign_key: 'book_id',join_table:'authors_books'
  validates_presence_of :first_name,:last_name
  scope :authors_number_of_books, -> (id) { where(:id => id).first.books.count }
  scope :author_entry_less_than_today_date,->{where("created_at <= ?", Date.today)}
   default_scope { order('created_at DESC') } 


 def name
  "#{first_name} #{last_name}"
 end
end
