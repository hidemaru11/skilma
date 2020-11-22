class MatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_mate, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit]

  def index
    if params[:search].present?
      @mates = Mate.search(params[:search]).sorted_desc
    else
      @mates = Mate.all.sorted_desc
    end
  end

  def new
    @mate = current_user.mates.build
  end
  
  def create
    @mate = current_user.mates.build(mate_params)
    if @mate.save
      flash[:notice] = "投稿しました"
      redirect_to mates_path
    else
      render :new
    end
  end

  def show
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @mate.user.id)
    unless @mate.user.id == current_user.id
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
    if @mate.update(mate_params)
      flash[:notice] = "編集しました"
      redirect_to @mate
   else
     render :edit
   end
  end

  def destroy
    @mate.destroy
    flash[:notice] = "削除しました"
    redirect_to mates_path
  end
end

private

  def mate_params
    params.require(:mate).permit(:title, :content, :area)
  end

  def set_mate
    @mate = Mate.find(params[:id])
  end

  def correct_user
    set_mate
    if current_user.id != @mate.user.id
      flash[:alert] = "アクセス権限がありません"
      redirect_to mates_path
    end
  end