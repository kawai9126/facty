class Public::CommentsController < ApplicationController
    def create
        @item = Item.find(params[:book_id])
        comment = current_end_user.comments.new(comment_params)
        comment.item_id = @item.id
        comment.save
        @comment = Comment.new
    end

    def destroy
        @item = Item.find(params[:item_id])
        Comment.find_by(id: params[:id], item_id: params[:item_id]).destroy
        @comment = Comment.new
    end

private
    def comment_params
        params.require(:comment).permit(:comment)
    end
end
