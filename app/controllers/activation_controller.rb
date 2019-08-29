class ActivationController < ApplicationController
  def update
    current_user.update_attributes(active: true)
    current_user.save
    flash[:success] = "Thank you! Your account is now activated!"
    # redirect_to dashboard_path
  end
end
