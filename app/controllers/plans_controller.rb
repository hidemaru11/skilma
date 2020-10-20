class PlansController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :needs_skill, :correct_skill, only: [:new]

  def new
    @skill = Skill.find(params[:skill_id])
    @plan = Plan.new
  end

  def create
    @skill = Skill.find(params[:skill_id])
    @plan = Plan.new(plan_params)
    if @plan.save
      flash[:notice] = "登録しました"
      redirect_to skill_path(@skill)
    else
      render "new"
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :content, :budget, :budget_unit_id, :skill_id)
  end

  def needs_skill
    unless current_user.skill
      flash[:alert] = "先にスキルを登録してください"
      redirect_to skills_path
    end
  end
  
  def correct_skill
    @skill = Skill.find(params[:skill_id])
    unless current_user.skill && @skill.id == current_user.skill.id
      flash[:alert] = "権限がありません"
      redirect_to skills_path
    end
  end
end
