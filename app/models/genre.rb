class Genre < ApplicationRecord
    has_many :items
    has_many :cart_items,dependent: :destroy
    has_many :order_items
end
