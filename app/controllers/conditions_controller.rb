class ConditionsController < ApplicationController



  def index
    # @conditions = Condition.joins(:chat).where(chats: { user: current_user })
    @conditions = current_user.conditions
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    if @condition.save
      redirect_to @condition
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def condition_params
    params.require(:condition).permit(:description, :symptoms, :diagnosed_on)
  end

end
