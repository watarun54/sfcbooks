class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = current_user.messages.new(message_params)
    is_success = true

    begin
      ActiveRecord::Base.transaction do
        if params[:message][:room_id].present?
          @room = Room.find(@message.room_id)
        else
          # 新規メッセージの場合は、Roomを作成する
          @room = Room.create!(
            item_id: params[:item_id],
            host_user_id: params[:host_user_id],
            guest_user_id: params[:guest_user_id]
          )
          @message.room_id = @room.id
        end
        @message.save!
      end
    rescue => e
      is_success = false
      redirect_path = @room.id ? @room : new_room_path(params: {item_id: params[:item_id]})
    end

    respond_to do |format|
      if is_success
        format.html { redirect_to @room, notice: 'Message was successfully created.' }
      else
        format.html { redirect_to redirect_path, notice: @message.errors.full_messages.first }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id, :user_id)
  end
end
