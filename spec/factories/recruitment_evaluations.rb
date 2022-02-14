FactoryBot.define do
  factory :recruitment_evaluation do
    recruitment_history
    recruiter
    result { [10, 20].sample }
    input_at { Time.current }
    description { "良いと思います" }
  end
end
