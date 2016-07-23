class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.integer :book_id
      t.integer :book_id
      t.integer :order_id
      t.integer :price
      t.integer :amount

      t.datetime :created_at
      t.datetime :updated_at
    end
  end

def self.down
  drop_table :order_items
end
end
