class LikesController < ApplicationController
  before_action :require_signin #, only: [:create]
  def create
    # By using a link
    # @event = Event.find(params[:event_id])
    # @user = current_user
    # @like = Like.new(event:@event, user: @user)
    # if @like.save
    #   redirect_to @event
    # end

    # By using a button
    # @event = Event.find(params[:event_id])
    @event = Event.find_by!(slug: params[:event_id])
    @event.likes.create!(user: current_user)
    redirect_to @event
  end

  def destroy
    # like = Like.find(params[:id])
    # Preventing malicious user from deleting other user's likes
    # like = Like.where("id = ? and user_id = ?", params[:id], current_user.id)
    like = current_user.likes.find(params[:id])
    like.destroy

    # event = Event.find(params[:event_id])
    event = Event.find_by!(slug: params[:event_id])
    redirect_to event
  end
end
