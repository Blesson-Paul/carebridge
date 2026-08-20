class ChatsController < ApplicationController
  def create
    @condition = Condition.find(params[:condition_id])
    @chat = Chat.new
    @chat.condition = @condition
    @chat.user = current_user
    if @chat.save!
      redirect_to condition_chat_path(@condition, @chat)
    else
      @chats = @condition.chat
      render "conditions/show"
    end
  end

  def show
    @condition = Condition.find(params[:condition_id])
    @chat = @condition.chat
    @message = Message.new
  end

  # private

  # def chat_params
  #   params.require(:chat).permit(:id, )
  # end
end
