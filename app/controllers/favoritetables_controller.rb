class FavoritetablesController < ApplicationController
  def create
    micropost = Micropost.find(params[:favorite_id])
    current_user.favorite(micropost)
    flash[:success] = 'このmicropostをお気に入りしました。'
    redirect_to user
  end

  def destroy
    micropost = Micropost.find(params[:favorite_id])
    current_user.unfollow(micropost)
    flash[:success] = 'このmicropostのお気に入りを解除しました。'
    redirect_to user
  end
end
