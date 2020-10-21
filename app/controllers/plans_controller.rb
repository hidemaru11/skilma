class PlansController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_skill, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :needs_skill, :correct_skill, only: [:new, :edit]

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      flash[:notice] = "登録しました"
      redirect_to skill_path(@skill)
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      flash[:notice] = "編集しました"
      redirect_to skill_plan_path(id: @plan.id, skill_id: @plan.skill.id)
    else
      render :edit
    end
  end

  def destroy
    @plan.destroy
    flash[:notice] = "削除しました"
    redirect_to skill_path(@skill)
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
  
  def set_skill
    @skill = Skill.find(params[:skill_id])
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def correct_skill
    set_skill
    unless current_user.skill && @skill.id == current_user.skill.id
      flash[:alert] = "権限がありません"
      redirect_to skills_path
    end
  end
end
