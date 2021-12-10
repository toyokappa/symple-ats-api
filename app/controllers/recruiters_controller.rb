class RecruitersController < ApplicationController
  def index
    # TODO: Pagingについて考える
    recruiters = Recruiter.all
    render json: RecruiterBlueprint.render(recruiters, view: :normal)
  end
end
