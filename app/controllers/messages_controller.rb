class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = current_user.messages.new(message_params)
    @room = Room.find(@message.room_id)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @room, notice: 'Message was successfully created.' }
      else
        format.html { redirect_to @room, notice: @message.errors.full_messages.first }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id, :user_id)
  end
end
