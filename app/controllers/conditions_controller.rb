class ConditionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_condition, only: [:show, :edit, :update, :destroy, :archive, :unarchive, :toggle_cured]

  def index
    @tab = params[:tab].presence || "active"
    all_conditions = current_user.conditions
    @unarchived_conditions = all_conditions.where(archived: false)
    @active_conditions = all_conditions.where(archived: false, cured: false)
    @cured_conditions = all_conditions.where(archived: false, cured: true)
    @archived_conditions = all_conditions.where(archived: true)

    @conditions = case @tab
                  when "all"
                    @unarchived_conditions
                  when "cured"
                    @cured_conditions
                  when "archived"
                    @archived_conditions
                  else # "active" is the default
                    @active_conditions
                  end
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

  def toggle_cured
    @condition.update(cured: !@condition.cured)
    status_text = @condition.cured? ? "marked as cured" : "marked as active"
    redirect_back fallback_location: @condition, notice: "\"#{@condition.description}\" was #{status_text}."
  end

  def archive
    @condition.update(archived: true)
    redirect_to conditions_path, notice: "\"#{@condition.description}\" was moved to your archive."
  end

  def unarchive
    @condition.update(archived: false)
    redirect_to @condition, notice: "\"#{@condition.description}\" has been restored to your active dashboard."
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
    params.require(:condition).permit(:description, :symptoms, :diagnosed_on, :cured, :archived)
  end
end
