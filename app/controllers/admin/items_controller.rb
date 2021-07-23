class Admin::ItemsController < ApplicationController
    def index
        @items = Item.page(params[:page])
        #@user = EndUser.find(params[:id])
    end
    def new
        @item = Item.new
    end
    def edit
        @item = Item.find(params[:id])
    end
    def show
        @item = Item.find(params[:id])
    end
    def create
        @item = Item.new(item_params)
        @item.save
        redirect_to admin_item_path(@item)
    end
    def update
        @item = Item.find(params[:id])
        @item.update(item_params)
        redirect_to admin_item_path(@item)
    end
    def destroy
    end

  private
    def item_params
        params.require(:item).permit(:image, :name, :contents, :genre_id, :non_price, :is_sale)
    end
    def end_user_params
        params.require(:end_user).permit(:user_name,:nick_name,:mail_number,:adress,:tel,:mail)
    end
end
