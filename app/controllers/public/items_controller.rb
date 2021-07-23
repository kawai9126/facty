class Public::ItemsController < ApplicationController
    
    def index
        @totals = Item.all
        @items = Item.page(params[:page]).reverse_order
    end
    def new
        @item = Item.new
    end
    def edit
        @item = Item.find(params[:id])
    end
    def show
        @item = Item.find(params[:id])
        @user = @item.end_user
        @cart_item = CartItem.new
    end
    def create
        @item = Item.new(item_params)
        @item.end_user_id = current_end_user.id
        if @item.save
        flash[:notice] = "投稿完了！！"
        redirect_to public_item_path(@item)
        else
        render :index
        end
    end
    
    def update
        @item = Item.find(params[:id])
        @item.update(item_params)
        redirect_to public_item_path(@item)
    end
    
    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        redirect_to public_item_path
    end
    
    private
    def item_params
        params.require(:item).permit(:image, :name, :contents, :genre_id, :non_price, :is_sale)
    end
    def end_user_params
        params.require(:end_user).permit(:nick_name, :user_name,:mail_number,:adress,:tel,:mail)
    end

end

