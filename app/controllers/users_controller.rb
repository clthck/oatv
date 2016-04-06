class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @total_clips_assigned = @user.becomes(Player).clips.count
    @total_clips_watched = PublicActivity::Activity.where(key: 'clip.watch', owner: @user).select(:trackable_id).distinct.count
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
