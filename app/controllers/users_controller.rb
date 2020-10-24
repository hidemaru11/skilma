class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy,]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit]

  def show
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