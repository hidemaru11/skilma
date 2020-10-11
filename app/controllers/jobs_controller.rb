class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit]

  def index
    @jobs = Job.all.sorted_desc
  end
  
  def new
    @job = current_user.jobs.build
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      flash[:notice] = "投稿しました"
      redirect_to jobs_path
    else
      render :new
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :content, :area, :budget)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def correct_user
    set_job
    if current_user.id != @job.user.id
      flash[:notice] = "アクセス権限がありません"
      redirect_to root_path
    end
  end
end
