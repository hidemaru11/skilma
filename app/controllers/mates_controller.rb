class MatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_mate, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit]

  def index
    if params[:search].present?
      @mates = Mate.search(params[:search]).sorted_desc
    elsif params[:user_id].present?
      @mates = Mate.my_posts(params[:user_id]).sorted_desc
    elsif @tag = params[:tag]
      @mates = Mate.tagged_with(params[:tag]).sorted_desc
    else
      @mates = Mate.all.sorted_desc
    end
    @tags = Mate.tag_counts_on(:tags).most_used(20).order('count DESC')
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
    @currentUserEntry=Entry.where(user_id: current_user.id) if user_signed_in?
    @userEntry=Entry.where(user_id: @mate.user.id)
    if user_signed_in? && @mate.user.id != current_user.id
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
    @tags = @mate.tag_counts_on(:tags).order('count DESC')
  end

  def edit
    @tags = Mate.tag_counts_on(:tags)
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
    params.require(:mate).permit(:title, :content, :area, :tag_list)
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