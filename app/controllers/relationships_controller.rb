class RelationshipsController < ApplicationController

  def create
    follower = current_user.relationships.new(followed_id: params[:user_id])
    follower.save
    redirect_to request.referer
  end

  def destroy
    follower = current_user.relationships.find_by(followed_id: params[:user_id])
    follower.destroy
    redirect_to request.referer
  end

end
