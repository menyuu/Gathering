class Admin::SearchesController < ApplicationController
  def search
    @content = params[:content]
    @model = params[:model]
    @word = params[:word]
    if @content == "id"
      case @model
      when "user"
        @search_result = EndUser.where(id: @word)
      when "post"
        @search_result = Post.where(id: @word)
      when "group"
        @search_result = Group.where(id: @word)
      end
    else
      case @model
      when "user"
        @search_result = EndUser.where(name: @word)
      when "post"
        @search_result = Post.where(text: @word)
      when "group"
        @search_result = Group.where(name: @word)
      end
    end
  end
end
