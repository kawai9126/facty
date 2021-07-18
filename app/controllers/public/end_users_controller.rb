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

end