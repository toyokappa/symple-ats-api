class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_recruiter!, unless: :devise_controller?

  private

  def status_400
    { status: 400, message: "入力エラーです" }
  end

  def status_401
    { status: 401, message: "権限がありません" }
  end

  def status_404
    { status: 404, message: "レコードが存在しません" }
  end
end
