class Admin::SearchesController < ApplicationController
  def search
    @model = params[:model]
    @word = params[:word]
    case @model
    when "user"
      @search_result = EndUser.where(id: @word)
    when "post"
      @search_result = Post.where(id: @word)
    when "group"
      @search_result = Group.where(id: @word)
    end
  end
end
