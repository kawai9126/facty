class Public::CartItemsController < ApplicationController
    before_action :authenticate_end_user!
 
    def index
        @cart_items = current_end_user.cart_items
        @total = 0
        
    end

    def update
        @cart_item = CartItem.find(params[:id])
        @cart_item.update(cart_item_params)
        redirect_to public_cart_items_path
    end

    def create
        cart_item = CartItem.where(end_user_id: current_end_user.id) #カートに物が入っているときに入らないようにreturnで出しています。
        if cart_item.present?
           flash[:notice] = 'すでにカートに商品が入っています！'
           redirect_to public_item_path(params[:cart_item][:item_id])
           return 
        end
        
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.end_user_id = current_end_user.id
        
        if @cart_item.save
        redirect_to public_cart_items_path
        else
        flash[:notice] = '個数を選択してください'
        redirect_to public_item_path(@cart_item.item_id)
        end
    end

    def destroy_all
        @cart_item = current_end_user.cart_items
        @cart_item.destroy_all
        redirect_to public_cart_items_path
    end

    private
    def cart_item_params
        params.require(:cart_item).permit(:end_user_id, :item_id,:number)
    end
end
