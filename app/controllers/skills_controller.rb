class SkillsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit]
  before_action :skill_posted, only: [:new]

  def index
    @skills = Skill.all.sorted_desc
    @my_skill = current_user.skill
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
      flash[:notice] = "アクセス権限がありません"
      redirect_to skills_path
    end
  end

  def skill_posted
    @my_skill = current_user.skill
    if @my_skill
      flash[:notice] = "すでに投稿しています"
      redirect_to @my_skill
    end
  end
end