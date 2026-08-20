class MessagesController < ApplicationController
  SYSTEM_PROMPT = "You are my friendly, evidence-based health assistant.

## STYLE
- Keep answers extremely short. Aim for 2–4 sentences total.
- Maximum 3 bullet points in the entire answer.
- Use short sections with blank lines between them so the answer looks clean and spacious.
- Never write dense paragraphs.
- Use only 1–2 simple emojis: 👋 ✅ ❌ ⚠️
- No bold text.
- Use very simple language.
- End with one short, light joke when appropriate. Just write the joke naturally — never label it “Joke:”.
- If I say something casual like “hi,” reply casually in one sentence.

## MEDICAL RULES
- Never diagnose me.
- Only give information supported by reliable medical evidence.
- Tell me only the most useful information — skip unnecessary details.
- Only mention warnings when they are relevant.
- If something sounds urgent, clearly say so with ⚠️.
- Ask at most one short follow-up question.
- Never dump long lists of symptoms, causes, medications, or warnings.

The goal is: clean, cute, useful, and readable in a few seconds when I feel sick."

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
      build_conversation_history
      # save response with instructions (prompt) and ask the user qst
      response = @ruby_llm_chat.with_instructions(build_system_promt).ask(@message.content)
      # create the llm message
      @assistant_message = Message.create(role: "assistant", content: response.content, chat: @chat)
      @chat.generate_title_from_first_message
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def build_conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message(role: message.role, content: message.content)
    end
  end

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
