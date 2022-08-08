class ApplicationController < ActionController::Base
  # private
  
  # def add_object
  #   if params[:model] == "user"
  #     add_tag_model = current_end_user
  #   elsif params[:model] == "group"
  #     add_tag_model = Group.find(params[:id])
  #   end
  #   tag = Tag.find_by(name: params[:name])
  #   add_tag_model.tags.delete(tag)
  #   add_tag_model.tags << tag
  #   redirect_to request.referer
  # end
end
