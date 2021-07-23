class AddDetailsToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :comment, :text
    add_column :comments, :end_user_id, :integer
    add_column :comments, :item_id, :integer
    
  end
end