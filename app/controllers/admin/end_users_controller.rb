class Admin::EndUsersController < ApplicationController
    def index
        @end_users = EndUser.page(params[:page])
    end
    def show
        @end_user = EndUser.find(params[:id])
        @end_users = EndUser.all
    end

private
    def end_user_params
        params.require(:end_user).permit(:user_name,:nick_name,:mail_number,:adress,:tel,:mail)
    end
end
