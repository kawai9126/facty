class Public::ItemsController < ApplicationController
    
    def index
        @items = Item.all
        #@items = Item.page(params[:page])　#雷追加後
    end
    def new
        @item = Item.new
    end
    def edit
        @item = Item.find(params[:id])
    end
    def show
        @item = Item.find(params[:id])
        @cart_item = CartItem.new
    end
    def create
        @item = Item.new(item_params)
        @item.save
        redirect_to public_item_path(@item)
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

end

