class PagesController < ApplicationController
  def home
    redirect_to conditions_path if user_signed_in?
  end
end
