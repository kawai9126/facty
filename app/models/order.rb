class Order < ApplicationRecord
    has_many :order_items
    belongs_to :end_user
    belongs_to :item
    
    
    enum payment_method: {"クレジット":0,"銀行":1}
    
    def total_price #商品合計をメソッドで計算
        total = 0
        self.order_items.each do |order_item|
            total += order_item.tax_included_price*order_item.number
    end
        total
    end


    def total_order #商品個数をメソッドで計算
        self.order_items.count
    end
end
