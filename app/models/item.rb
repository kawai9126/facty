class Item < ApplicationRecord
    has_many :cart_items,dependent: :destroy
    has_many :order_items
    belongs_to :end_user

    belongs_to :genre

    
    attachment :image
    
    
    def add_tax_price
        (self.non_price * 1.10).round
    end

end
