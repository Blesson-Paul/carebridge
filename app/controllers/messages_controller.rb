class MessagesController < ApplicationController

  SYSTEM_PROMPT = "You are a medical doctor. I am a patient suffering from the said condition, seeking advice on how to get better. don't diagnose me, give me simple advice based only on validated medical studies, only answer with facts. answer with concisely in markdown"
  p SYSTEM_PROMPT
  def create
    # find the chat for
      #1. the current user and
    raise
    @chat = current_user.chats.find[:chat_id]
      #2. condition
    @condition = @chat.condition
    #creating the message + strong params
    @message = Message.new(message_params)
    #setting the message chat
    @message.chat = @chat
    #setting the role (user)
    @message.role = "user"
    #save the message
    if @message.save
      # choose llm
      ruby_llm_chat = RubyLLM.chat
      # save response with instructions (prompt) and ask the user qst
      response = ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      # create the llm message
      Message.create(role: "assistant", content: response.content, chat: @chat)
      #redirect to the chat path
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    paras.require(:message).permit(:content)
  end

  # def find_condition
  #   @chat = current_user.chats.find[:chat_id]
  #     #2. condition
  #   @condition = @chat.condition
  # end

end
