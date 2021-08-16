class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
  has_many :shipping_addresses, dependent: :destroy
  has_many :cart_items,dependent: :destroy
  has_many :orders,dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed
  
  
  attachment :profile_image
  
  
  
  def follow(end_user_id)
    relationships.create(followed_id: end_user_id)
  end

  def unfollow(end_user_id)
    relationships.find_by(followed_id: end_user_id).destroy
  end

  def following?(end_user)
    followings.include?(end_user)
  end
  
  def total_price
    total = 0
    self.cart_items.each do |cart_item|
      total += cart_item.add_tax_price_total
    end
    total
  end
end
