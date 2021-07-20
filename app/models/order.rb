class Order < ApplicationRecord
    has_many :order_items
    belongs_to :end_user
    
    def total_price #商品合計をメソッドで計算
        total = 0
        self.order_items.each do |order_item|
            total += order_item.tax_included_price*order_item.number
    end
        total
    end


    def total_order #商品個数をメソッドで計算
        number = 0
        self.order_items.each do |f|
            number += f.number
        end
        number
    end
end
