class AddBuyerNameToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :buyer_name, :string, null: false
  end
end
