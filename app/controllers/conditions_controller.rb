class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_condition, only: [ :show ]

  def index
    @conditions = current_user.conditions
  end

  def show
  end

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    @condition.user = current_user

    if @condition.save
      redirect_to @condition, notice: "Condition was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_condition
    @condition = current_user.conditions.find(params[:id])
  end

  def condition_params
    params.require(:condition).permit(:description, :symptoms, :diagnosed_on)
  end
end
