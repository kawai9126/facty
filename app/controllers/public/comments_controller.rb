class Public::CommentsController < ApplicationController
    def create
        @item = Item.find(params[:item_id])
        comment = current_end_user.comments.new(comment_params)
        comment.item_id = @item.id
        comment.save
        @comment = Comment.new
        redirect_to public_item_path(@item.id)
    end

    def destroy
        @item = Item.find(params[:item_id])
        Comment.find(params[:id]).destroy
        @comment = Comment.new
        redirect_to public_item_path(@item.id)
    end

private
    def comment_params
        params.require(:comment).permit(:comment)
    end
end
