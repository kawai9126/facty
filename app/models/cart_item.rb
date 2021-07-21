class CartItem < ApplicationRecord
    belongs_to :end_user
    belongs_to :item
    
    def add_tax_price_total
        self.number * self.item.add_tax_price
    end
end