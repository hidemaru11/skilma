class SkillsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit]

  def index
    @skills = Skill.all.sorted_desc
  end

  def new
    @skill = current_user.build_skill
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