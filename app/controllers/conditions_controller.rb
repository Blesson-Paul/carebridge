class ConditionsController < ApplicationController



  def index
    # @conditions = Condition.joins(:chat).where(chats: { user: current_user })
    @conditions = current_user.conditions
  end

  def show
    @condition = Condition.find(params[:id])
  end

end
