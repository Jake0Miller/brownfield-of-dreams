class UsersController < ApplicationController
  def show
		token = current_user.github_token
		if token
	    render locals: {
				github_token: token,
	      repos_facade: RepositoryFacade.new(token),
	      followers_facade: FollowerFacade.new(token),
				following_facade: FollowingFacade.new(token)
	    }
		end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
