class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.includes(:videos).find(params[:id])
		redirect_to new_admin_tutorial_video_path(tutorial) if tutorial.videos.empty?
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
