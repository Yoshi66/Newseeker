class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:relationship][:followed_id])
    p @user
    logger.debug "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    current_user.follow!(@user)
    respond_to do |format|
      logger.debug "AAgnreiug;aeglme;gio"
      format.html { redirect_to @user }
      # format.html { redirect_to @user, object: @user }
      # format.js {render 'create', object: @user }
      format.js {render 'create' }
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      logger.debug "AAgnreiug;aeglme;gio"
      format.html { redirect_to @user }
      format.js { render 'destroy'}
    end
  end
end
