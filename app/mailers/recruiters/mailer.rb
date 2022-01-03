class Recruiters::Mailer < Devise::Mailer
  def headers_for(action, opts)
    super.merge!(template_path: 'recruiters/mailer')
  end

  def confirmation_instructions(record, token, opts={})
    if record.unconfirmed_email.blank?
      opts[:subject] = "【TheATS】アカウントの登録を完了してください"
    else
      opts[:subject] = "【TheATS】メールアドレスの変更手続きを完了してください"
    end

    super
  end

end
