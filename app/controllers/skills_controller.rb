class SkillsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit]
  before_action :skill_posted, only: [:new]

  def index
    @skills = Skill.all.sorted_desc
    if user_signed_in?
      @my_skill = current_user.skill
    end
  end

  def new
    @skill = current_user.build_skill
  end
  
  def create
    @skill = current_user.build_skill(skill_params)
    if @skill.save
      flash[:notice] = "投稿しました"
      redirect_to skills_path
    else
      render :new
    end
  end

  def show
    @plans = Plan.where(skill_id: params[:id]).sorted_desc
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @skill.user.id)
    unless @skill.user.id == current_user.id
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
    if @skill.update(skill_params)
      flash[:notice] = "編集しました"
      redirect_to @skill
    else
      render :edit
    end
  end

  def destroy
    @skill.destroy
    flash[:notice] = "削除しました"
    redirect_to skills_path
  end
  
  private
  
  def skill_params
    params.require(:skill).permit(:title, :content)
  end
  
  def set_skill
    @skill = Skill.find(params[:id])
  end
  
  def correct_user
    set_skill
    if current_user.id != @skill.user.id
      flash[:alert] = "アクセス権限がありません"
      redirect_to skills_path
    end
  end

  def skill_posted
    @my_skill = current_user.skill
    if @my_skill
      flash[:alert] = "すでに投稿しています"
      redirect_to @my_skill
    end
  end
end