class Public::ShippingAddressesController < ApplicationController
    before_action :authenticate_end_user!
    def index
        @shipping_addresses = current_end_user.shipping_addresses
        @shipping_address = ShippingAddress.new
    end 
  
    def edit
        @shipping_address = ShippingAddress.find(params[:id])
    end
  
    def create
        @shipping_address = ShippingAddress.new(sa_params)
        @shipping_address.end_user_id = current_end_user.id
        @shipping_address.save
        redirect_to public_s_hipping_addresses_path
    end 
  
    def update
        @shipping_address = ShippingAddress.find(params[:id])
        @shipping_address.end_user_id = current_end_user.id
        if @shipping_address.update(sa_params)
        redirect_to public_shipping_addresses_path
        else
        render :edit
        end
    end
  
    def destroy
        @shipping_address = ShippingAddress.find(params[:id])
        @shipping_address.end_user_id = current_end_user.id
        @shipping_address.destroy
        redirect_to public_shipping_addresses_path
    end
    private 
    def sa_params
        params.require(:shipping_address).permit(:mail_number, :delivery_address, :direction)
    end
end
