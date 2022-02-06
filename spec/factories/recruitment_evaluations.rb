FactoryBot.define do
  factory :recruitment_evaluation do
    recruitment_history { nil }
    recruiter { nil }
    result { 1 }
    input_at { "2022-02-06 05:37:27" }
    description { "MyText" }
  end
end
