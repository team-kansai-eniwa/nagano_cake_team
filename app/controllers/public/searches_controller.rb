class Public::SearchesController < ApplicationController

  def search
    @word = (params[:word])
    @items = Item.where("name LIKE?", "%#{@word}%").page(params[:page])
    @genres = Genre.all
  end

end
