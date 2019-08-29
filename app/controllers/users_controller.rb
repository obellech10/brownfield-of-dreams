class UsersController < ApplicationController
  def show
    render locals: {
      facade: GithubRepositoriesFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
      flash[:message] = "Logged in as #{user.first_name}"
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def github_creds
    token = request.env["omniauth.auth"]["credentials"]["token"]
    nickname = request.env["omniauth.auth"]["info"]["nickname"]
    user_update(token, nickname)
  end

  private

  def user_update(token, nickname)
    current_user.update_attribute(:github_token, token)
    current_user.update_attribute(:github_nickname, nickname)
    flash[:sucess] = "#{current_user.first_name} is now connected to Github"
    redirect_to dashboard_path
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
