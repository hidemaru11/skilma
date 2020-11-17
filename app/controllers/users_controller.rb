class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :following, :followers]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit]

  def show
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom.nil?
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "編集しました"
      redirect_to @user
    else
      render :edit
    end
  end

  def following
    @users = @user.following
    render 'show_follow'
  end
  
  def followers
    @users = @user.followers
    render 'show_follow'
  end
  
  private
  
    def user_params
      params.require(:user).permit(:username, :profile)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def correct_user
      set_user
      if current_user.id != @user.id
        flash[:alert] = "アクセス権限がありません"
        redirect_to root_path
      end
    end
end