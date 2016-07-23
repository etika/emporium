class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|

      t.string :email
      t.string :phone_number
      t.string :ship_to_first_name
      t.string :ship_to_last_name
      t.string :ship_to_address
      t.string :ship_to_city
      t.string :ship_to_postal_code
      t.string :ship_to_country
      t.string :customer_ip
      t.string :status
      t.string :error_message
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

def self.down
   drop_table :orders
end
end
