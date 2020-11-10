class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new((message_params).merge(user_id: current_user.id))
      @room = @message.room
      if @message.save
        @partnerEntry = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
        notification = current_user.active_notifications.build(
          room_id: @room.id,
          message_id: @message.id,
          visited_id: @partnerEntry.user_id,
          visitor_id: current_user.id,
          action: "message"
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notificatioon.valid?

        redirect_to "/rooms/#{@message.room_id}"
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:notice] = "削除しました"
    redirect_back(fallback_location: root_path)
  end

  private
    def message_params
      params.require(:message).permit(:user_id, :room_id, :content)
    end
end
