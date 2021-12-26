class Auth::RecruitersController < ApplicationController
  def show
    render json: RecruiterBlueprint.render(current_recruiter, view: :normal)
  end
end
