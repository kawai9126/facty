class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.string :contents, null: false
      t.integer :non_price, null: false
      t.string :image_id, null: false
      t.boolean :is_sale, default: false, null: false
      t.integer :end_user_id
    
      t.timestamps
    end
  end
end
