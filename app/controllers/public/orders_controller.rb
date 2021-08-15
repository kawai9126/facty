class Public::OrdersController < ApplicationController
    before_action :authenticate_end_user!
    def index  # 購入履歴
        @end_user = current_end_user
        @orders = @end_user.orders.all.reverse_order
    end
    def buyer #販売履歴
        @orders = Order.includes(:item).where(items: {end_user_id: current_end_user}).reverse_order #includesで事前にオーダーに関するアイテムの情報を持ってきてそこから出品者のオーダーを見つけるフィルタリングをして出品者の情報があるオーダーをの情報を出せるようにしています。
    end

    def show
        @order = Order.find(params[:id])
        @order_items = @order.order_items
    end
    
    def new
        @order = Order.new
    end
    
    def check #sessionに入れることで他の場所にも送れるようにしています。
        @shipping_fee = 500.to_i
        check_order = order_params
        check_order[:end_user_id] = current_end_user.id
        check_order[:shipping_fee] = @shipping_fee
        check_order[:invoice] = @shipping_fee + current_end_user.total_price
        @cart_items = current_end_user.cart_items
        if params[:order][:adress_option].to_i == 0
        # adress_option が 0の場合
        check_order[:mail_number] = current_end_user.mail_number
        check_order[:delivery_address] = current_end_user.adress
        check_order[:direction] = current_end_user.user_name
        elsif params[:order][:adress_option].to_i == 1
        # adress_option が 1の場合
        @add_order = ShippingAddress.find(params[:order][:shipping_addresses])
        check_order[:mail_number] = @add_order.mail_number
        check_order[:delivery_address] = @add_order.delivery_address
        check_order[:direction] = @add_order.direction
        elsif params[:order][:adress_option].to_i == 2
        # adress_option が 2の場合
        check_order[:mail_number] = order_params[:mail_number]
        check_order[:delivery_address] = order_params[:delivery_address]
        check_order[:direction] = order_params[:direction]
        end
        session[:save_order] = check_order
    end

    def create
        @order = Order.new(session[:save_order])
        #@order.save
        #ShippingAddress.find_or_create_by!(end_user_id: current_end_user.id,direction: @order.direction,delivery_address: @order.delivery_address,mail_number: @order.mail_number)
        @cart_items = current_end_user.cart_items
        save_order = session[:save_order].symbolize_keys #認識できなかったためシンボル化させ認識できるようシンボライズキィを使用しました。
        ShippingAddress.find_or_create_by!(end_user_id: current_end_user.id,direction: save_order[:direction],delivery_address: save_order[:delivery_address],mail_number: save_order[:mail_number]) #なかった時にクリエイトしています
        @cart_items = current_end_user.cart_items
        @cart_items.each do |cart| 
          order = Order.new(session[:save_order])
          order.item_id = cart.item_id #order.item_idにcart.item_idを反映させてます
          if order.save 
            OrderItem.create!(item_id: cart.item.id, order_id: order.id, number: cart.number, tax_included_price: cart.item.add_tax_price )
          end
       end
       current_end_user.cart_items.destroy_all
       session[:save_order].clear #ここでクッキーに保管されているものを削除します。
       redirect_to thanks_public_orders_path
    end
    
    def thanks
    end
   
   private
    def order_params
     params.require(:order).permit(:direction,:payment_method,:delivery_address,:mail_number,:end_user_id,:invoice,:shipping_fee)
    end
end
