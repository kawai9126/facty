class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.integer :end_user_id, null: false
      t.string :direction, null: false
      t.text :delivery_address, null: false
      t.integer :mail_number, null: false
      
      t.timestamps
    end
  end
end
