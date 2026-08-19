class MessagesController < ApplicationController
  SYSTEM_PROMPT = "You are a medical doctor. I am a patient suffering from the said condition, seeking advice on how to get better. don't diagnose me, give me simple advice based only on validated medical studies, only answer with facts. answer with concisely in markdown."

  def create
    # find the chat for
    # 1. the current user and
    @chat = current_user.chats.find(params[:chat_id])

    @@continuous_params = params
    # 2. condition
    @condition = @chat.condition
    # creating the message + strong params
    @message = Message.new(message_params)
    # setting the message chat
    @message.chat = @chat
    # setting the role (user)
    @message.role = "user"
    # save the message
    if @message.save
      # choose llm
      @ruby_llm_chat = RubyLLM.chat
      # save response with instructions (prompt) and ask the user qst
      response = @ruby_llm_chat.with_instructions(build_system_promt).ask(@message.content)
      # create the llm message
      @assistant_message = Message.create(role: "assistant", content: response.content, chat: @chat)
      # redirect to the chat path
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def build_system_promt
    specialization = "you are a specialist in #{Condition.find(Chat.find(params[:chat_id]).condition_id).description}"
    [ SYSTEM_PROMPT, specialization ].compact.join("\n\n")
  end

  # def find_condition
  #   @chat = current_user.chats.find[:chat_id]
  #     #2. condition
  #   @condition = @chat.condition
  # end
end
