class AddDetailsToFavorite < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :item_id, :integer
  end
end
