class Public::EndUsersController < ApplicationController
    def show
        @end_user = current_end_user
    end
    
    def edit
        @end_user = current_end_user
    end
    
    def update
           @end_user = current_end_user
        if @end_user.update(end_user_params)
           redirect_to public_end_user_path
        else
           render "edit"
        end
    end

    private
    def end_user_params
     params.require(:end_user).permit(:nick_name, :user_name,:mail_number,:adress,:tel,:mail)
    end

end
