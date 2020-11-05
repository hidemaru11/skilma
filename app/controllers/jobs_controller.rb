class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_job, only: [:show, :edit, :update, :destroy]
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

  def show
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @job.user.id)
    unless @job.user.id == current_user.id
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
    if @job.update(job_params)
      flash[:notice] = "編集しました"
      redirect_to @job
   else
     render :edit
   end
  end

  def destroy
    @job.destroy
    flash[:notice] = "削除しました"
    redirect_to jobs_path
  end

  private

  def job_params
    params.require(:job).permit(:title, :content, :area, :budget, :budget_unit_id)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def correct_user
    set_job
    if current_user.id != @job.user.id
      flash[:alert] = "アクセス権限がありません"
      redirect_to jobs_path
    end
  end
end
