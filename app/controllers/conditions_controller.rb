class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_condition, only: [ :show, :destroy, :edit, :update]

  def index
    @conditions = current_user.conditions
    @active_conditions = @conditions.where(cured: [false, nil]).count
    @unactive_conditions = @conditions.where(cured: true).count
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

  def destroy
    # find the condition
    # grab a weapon
    # kill it
    @condition.destroy!
    redirect_to conditions_path
  end

  def edit
  end

  def update
    if @condition.update(condition_params)
      redirect_to @condition, notice: "your condition was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end

  end

  private

  def set_condition
    @condition = current_user.conditions.find(params[:id])
  end

  def condition_params
    params.require(:condition).permit(:description, :symptoms, :diagnosed_on, :cured)
  end
end
