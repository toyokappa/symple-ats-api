# == Schema Information
#
# Table name: recruiters
#
#  id                     :bigint           not null, primary key
#  provider               :string(255)      default("email"), not null
#  uid                    :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  name                   :string(255)
#  nickname               :string(255)
#  image                  :string(255)
#  email                  :string(255)
#  level                  :integer          default(1)
#  tokens                 :text(65535)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
FactoryBot.define do
  factory :recruiter do
    sequence(:name) {|n| "リクルーター#{n}" }
    sequence(:nickname) {|n| "recruiter#{n}" }
    sequence(:email) {|n| "recruiter#{n}@symple.com" }
    password { "123456" }
    level { [*1..3].sample }
  end
end
