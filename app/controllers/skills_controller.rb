class SkillsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit]

  def index
    if params[:search].present?
      @skills = Skill.search(params[:search]).sorted_desc
    elsif params[:user_id].present?
      @skills = Skill.my_posts(params[:user_id]).sorted_desc
    elsif @tag = params[:tag]
      @skills = Skill.tagged_with(params[:tag]).sorted_desc
    else
      @skills = Skill.all.sorted_desc
    end
    @tags = Skill.tag_counts_on(:tags).most_used(20).order('count DESC')
  end

  def new
    @skill = current_user.skills.build
  end
  
  def create
    @skill = current_user.skills.build(skill_params)
    if @skill.save
      flash[:notice] = "投稿しました"
      redirect_to skills_path
    else
      render :new
    end
  end

  def show
    @currentUserEntry=Entry.where(user_id: current_user.id) if user_signed_in?
    @userEntry=Entry.where(user_id: @skill.user.id)
    if user_signed_in? && @skill.user.id != current_user.id
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
    @tags = @skill.tag_counts_on(:tags).order('count DESC')
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
    params.require(:skill).permit(:title, :content, :tag_list)
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
end