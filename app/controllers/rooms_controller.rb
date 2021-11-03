class RoomsController < ApplicationController

  def create
    @room = Room.new
    @room.save
    @entry1 = Entry.new
    @entry1.room_id = @room.id
    @entry1.user_id = current_user.id
    @entry1.save
    @entry2 = Entry.new(entry2_params)
    @entry2.room_id = @room.id
    @entry2.save
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
  private
    def entry2_params
      params.require(:entry).permit(:user_id)
    end
end