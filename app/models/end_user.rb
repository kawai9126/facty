class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
  has_many :shipping_addresses, dependent: :destroy
  has_many :cart_items,dependent: :destroy
  has_many :orders,dependent: :destroy
  has_many :items, dependent: :destroy
  
  def total_price
    total = 0
    self.cart_items.each do |cart_item|
      total += cart_item.add_tax_price_total
    end
    total
  end
end
