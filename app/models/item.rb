class Item < ApplicationRecord
    has_many :cart_items,dependent: :destroy
    has_many :order_items
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :items
    belongs_to :end_user

    belongs_to :genre


    
    attachment :image
    
    def favorited_by?(user)
        favorites.where(end_user_id: user.id).exists?
    end
    
    def add_tax_price
        (self.non_price * 1.10).round
    end

end
