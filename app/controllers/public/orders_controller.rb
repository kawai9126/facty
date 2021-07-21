class Public::OrdersController < ApplicationController
    before_action :authenticate_end_user!
    def index
        @end_user = current_end_user
        @orders = @end_user.orders.all
        @cart_items = @end_user.cart_items.all
    end
    
    def show
        @order = Order.find(params[:id])
        @order_items = @order.order_items
    end
    
    def new
        @order = Order.new
    end
    
    def check
        session[:save_order] = Order.new()
        session[:save_order] = order_params
        session[:save_order][:end_user_id] = current_end_user.id
        @shipping_fee = 800.to_i
        session[:save_order][:shipping_fee] = @shipping_fee
        session[:save_order][:invoice] = @shipping_fee + current_end_user.total_price
        @cart_items = current_end_user.cart_items
       if params[:order][:adress_option].to_i == 0
        session[:save_order][:mail_number] = current_end_user.mail_number
        session[:save_order][:delivery_address] = current_end_user.adress
        session[:save_order][:direction] = current_end_user.user_name
       elsif params[:order][:adress_option].to_i == 1
        @add_order = ShippingAddress.find(params[:order][:shipping_addresses]) 
        session[:save_order][:mail_number] = @add_order.mail_number
        session[:save_order][:delivery_address] = @add_order.delivery_address 
        session[:save_order][:direction] = @add_order.direction 
       elsif params[:order][:adress_option].to_i == 2
        session[:save_order][:mail_number] = order_params[:mail_number]
        session[:save_order][:delivery_address] = order_params[:delivery_address] 
        session[:save_order][:direction] = order_params[:direction]
       end
       
       
      
    end

    def create
        @order = Order.new(session[:save_order])
        @order.save
        ShippingAddress.find_or_create_by(end_user_id: current_end_user.id,direction: @order.direction,delivery_address: @order.delivery_address,mail_number: @order.mail_number)
        @cart_items = current_end_user.cart_items
        @cart_items.each do |cart| 
        OrderItem.create(item_id: cart.item.id, order_id: @order.id, number: cart.number, tax_included_price: cart.item.add_tax_price )
       end
       current_end_user.cart_items.destroy_all
       session[:save_order].clear
       redirect_to thanks_public_orders_path
    end
    
    def thanks
    end
   
   private
    def order_params
     params.require(:order).permit(:direction,:payment_method,:delivery_address,:mail_number,:end_user_id,:invoice,:shipping_fee)
    end
end
