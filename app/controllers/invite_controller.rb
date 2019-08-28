class InviteController < ApplicationController
  def new
  end

  def create
    user = find_github_user(current_user.token("github"), params[:"Github Handle"])
    if user.keys.include?("message") && user["message"] == "Not Found"
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    else
      email = user["email"]
      flash[:success] = "Successfully sent invite!"
      ActivateMailer.invite(email).deliver_now
    end
    redirect_to dashboard_path
  end

  private

  def service(token)
    @_service ||= GithubService.new(token)
  end

  def find_github_user(token, handle)
    @_user_data ||= service(token).user_lookup(handle)
  end
end
