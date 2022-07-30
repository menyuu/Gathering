class EndUser::SearchesController < ApplicationController
  def search
    @word = params[:word]
  end
end
