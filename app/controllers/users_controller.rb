class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show]

  def show
    p "AAAAAAAAAAAAAAAA"
    @key = params[:key]
    p params
    p @user
    p "BBBBBBBBBBBBBBBBBBBBBBBBBB"
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
