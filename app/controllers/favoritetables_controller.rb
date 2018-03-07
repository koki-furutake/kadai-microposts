class FavoritetablesController < ApplicationController
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = 'このmicropostをお気に入りしました。'
    redirect_to root_path
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = 'このmicropostのお気に入りを解除しました。'
    redirect_to root_path
  end
end