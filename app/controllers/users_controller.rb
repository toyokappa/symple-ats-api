class UsersController < ApplicationController
  def index
    # TODO: Pagingについて考える
    users = User.all
    render json: UserBlueprint.render(users, view: :normal)
  end
end
