class SearchsController < ApplicationController
    def index
      @faculty = params[:faculty]
      @search = params[:search]
      @text = params[:text]
      if @faculty == 'EndUser'
        @users = EndUser.search(params[:search],params[:text])
      else
        @items = Item.search(params[:search],params[:text])
      end
    end
end
