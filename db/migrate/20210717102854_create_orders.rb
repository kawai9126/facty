class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :end_user_id, null: false
      t.string :direction, null: false
      t.integer :payment_method, default: 0, null: false
      t.text :delivery_address, null: false
      t.string :mail_number, null: false
      t.integer :invoice, default: 0, null: false
      t.integer :shipping_fee
      
      t.timestamps
    end
  end
end
