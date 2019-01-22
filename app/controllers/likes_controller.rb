class LikesController < ApplicationController
  before_action :require_user_logged_in

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.like_m(micropost)
    flash[:success] = "お気に入りにしました。"
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unlike_m(micropost)
    flash[:success] = "お気に入りを解除しました。"
    redirect_back(fallback_location: root_path)
  end

end
