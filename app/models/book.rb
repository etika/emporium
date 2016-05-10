class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors,association_foreign_key: 'author_id',join_table:'authors_books'
  belongs_to :publisher
  validates_length_of :title,:in=>1..255
  validates_presence_of :publisher
  validates_presence_of :authors
  validates_presence_of :published_at
  validates_numericality_of :page_count,:only_integer=>true
  validates_numericality_of :price
  validates_format_of :isbn ,:with=>/[0-9\-xX]{13}/
  validates_uniqueness_of :isbn
  has_many :cart_items
  has_many :carts,:through =>:cart_items
  def author_names
    self.authors.map do |a|
      a.name
    end.join(", ") rescue ""
  end
    def self.latest
     find :all,:limit=>10,:order=>"books.id.desc",:include=>[:authors,:publisher]
    end
end