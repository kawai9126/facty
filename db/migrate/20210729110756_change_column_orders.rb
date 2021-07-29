class ChangeColumnOrders < ActiveRecord::Migration[5.2]
  def change
    change_column_null :orders, :buyer_name, true
    change_column_null :orders, :exhibitor_id, true
  end
end
