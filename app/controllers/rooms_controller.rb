class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    user = current_user
    currentEntries = current_user.entries
    myRoomIds = []

    currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end

    @partnerEntries = Entry.where(room_id: myRoomIds).where("user_id != ?", user.id)
  end
  
  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create((entry_params).merge(room_id: @room.id))
    redirect_to @room
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.order(created_at: :desc)
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def entry_params
      params.require(:entry).permit(:user_id, :room_id)
    end
end
