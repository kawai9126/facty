class AddExhibitorIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :exhibitor_id, :string, null: false
  end
end
