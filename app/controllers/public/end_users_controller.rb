class Public::EndUsersController < ApplicationController
    
    def index
        # @user = current_user
        @users = EndUser.all
    end
    def show
        @end_user = current_end_user
        @user = EndUser.find(params[:id])
        @items = @user.items.all.reverse_order
    end
    
    def edit
        @end_user = current_end_user
    end
    
    def update
           @end_user = current_end_user
        if @end_user.update(end_user_params)
           redirect_to public_end_user_path
        else
           render :edit
        end
    end

    private
    def end_user_params
        params.require(:end_user).permit(:nick_name, :user_name,:mail_number,:adress,:tel,:mail,:profile_image,:introduction)
    end
    def item_params
        params.require(:item).permit(:image, :name, :contents, :genre_id, :non_price, :is_sale)
    end

end
