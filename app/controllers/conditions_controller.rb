class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_condition, only: [:show, :edit, :update, :destroy]

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
    if @condition.save
      Chat.create!(user: current_user, condition: @condition, title: @condition.description)
      redirect_to @condition, notice: "Condition was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @condition.update(condition_params)
      redirect_to @condition, notice: "Condition was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @condition.destroy
    redirect_to conditions_path, notice: "Condition was successfully removed.", status: :see_other
  end

  private

  def set_condition
    @condition = current_user.conditions.find(params[:id])
  end

  def condition_params
    params.require(:condition).permit(:description, :symptoms, :diagnosed_on, :cured)
  end
end
