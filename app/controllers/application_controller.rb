class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  private

  def status_400
    { status: 400, message: "入力エラーです" }
  end

  def status_404
    { status: 404, message: "レコードが存在しません" }
  end
end
