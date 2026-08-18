class ChatsController < ApplicationController

  def create
    @condition = Condition.find(params[:condition_id])
    @chat = Chat.new(title: "Untitled")
    @chat.condition = @condition
    if @chat.save
      redirect_to chat_path(@chat)
    else
      # @chats = @condition.chat.where(user: current_user)
      render "conditons/show"
    end
  end

  def show

  end

  private

  def chat_params
    params.require(:chat).permit
  end
end
